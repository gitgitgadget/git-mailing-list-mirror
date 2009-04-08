From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] archive: add a failure test wrt .gitattributes 
 misreading
Date: Wed, 08 Apr 2009 12:20:12 -0700
Message-ID: <7vab6rkl5f.fsf@gitster.siamese.dyndns.org>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 21:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrdLW-0001Cf-Q3
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 21:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763619AbZDHTUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbZDHTUU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 15:20:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841AbZDHTUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 15:20:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AEC8BA84AE;
	Wed,  8 Apr 2009 15:20:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8EE5EA84AD; Wed,
  8 Apr 2009 15:20:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B5CAE1A-2472-11DE-934A-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116111>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> "git archive" is used to create archives from a tree (or commit), so
> it should not consult any .gitattributes files on working directory.
>
> It currently does,...

=2E..which _might_ be actively used as a _feature_ by people; I do not =
think
it is a bad idea to have a mode of operation where it solely works with
in-tree attributes ignoring the work tree ones, and I suspect we probab=
ly
would want to make that the default, but "so it should not" is probably=
 a
bit too strong.

=46or example, an older version may record $Id$ with keyword expansion =
set
in its in-tree .gitattributes, and you later found it to be a mistake a=
nd
have removed it in the current version.  Re-exporting an older version
with the current code wouldn't have $Id$ expanded, but with your patch =
it
will.

A stronger example would be crlf conversion, I suppose, but the same "w=
ith
the current code we can fix it up but after this patch we can't" worry
applies.

So perhaps you may want to resurrect the current behaviour with a new
option --fix-attributes, whose description would be "normally the comma=
nd
takes attributes settings from the tree being exported, but .gitattribu=
tes
files in it may record wrong attributes you may want to fix while
exporting.  With this option, corresponding .gitattributes files in the
work tree will override the in-tree .gitattributes" or something like
that.
