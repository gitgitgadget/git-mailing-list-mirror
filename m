From: "Marco Costalba" <mcostalba@gmail.com>
Subject: git-format-patch possible regressions
Date: Thu, 25 May 2006 21:23:23 +0200
Message-ID: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 25 21:23:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjLQe-0004nn-Ck
	for gcvg-git@gmane.org; Thu, 25 May 2006 21:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWEYTXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 15:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWEYTXY
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 15:23:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:26500 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030362AbWEYTXX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 15:23:23 -0400
Received: by wr-out-0506.google.com with SMTP id i24so1998559wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 12:23:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SPik1qLiepq6x10ybQcibXvlFLeSWXm7FMRxFMpRtGY9Mn/ovIzmtyMt4872Hol5C8SZLpDt/+STGxVtsppwvvbYWJ8vaHqsCwVZEds0PLWKoabmKB4jtclWF/h7trbqqMFWavTUMLBhFKclIR0g1HAHE41i4qTUr4gvIkescAk=
Received: by 10.64.152.19 with SMTP id z19mr4607369qbd;
        Thu, 25 May 2006 12:23:23 -0700 (PDT)
Received: by 10.64.142.14 with HTTP; Thu, 25 May 2006 12:23:23 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20755>

A couple of possible regressions:

1) Unreconized --signoff option

$ git --version
git version 1.3.3.ged90
$ git-format-patch -s HEAD^..HEAD
0001-cat-file-document-p-option.txt
$ git-format-patch --signoff HEAD^..HEAD
fatal: unrecognized argument: --signoff


2) Unhandled ranges list

$ git --version
git version 1.3.3.ged90
$ git-format-patch -s HEAD^..HEAD HEAD^^..HEAD^
0001-cat-file-document-p-option.txt

$ git --version
git version 1.3.3.gf205
git checkout -b test 51ce34b9923d9b119ac53414584f80e05520abea
$ git-format-patch HEAD^..HEAD HEAD^^..HEAD^
0001-Builtin-git-show-branch.txt
0002-Builtin-git-apply.txt

Both regressions brake qgit. The first one is easy to fix (--signoff  --> -s)
The second one is not so easy.
It is use to format a patch series starting from a mouse selected
multiple revisions. Note that the revisions could be not consecutive.
Note also that looping git-format-patch for each revision does not
updates patch number that always stay at 0001.

Feeding all the selected revisions in one go in the form
git-format-patch sel1^..sel1  sel2^..sel2    ........  seln^..seln is
the only way I have found to:

1) create a patch series of (randomly) selected revisions

2) increment patch numbers for each patch


   Marco
