From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 16:56:04 +0200
Message-ID: <200806031656.04780.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806031614.29161.jnareb@gmail.com> <b77c1dce0806030740td820c52ve45619812313776c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>,
	"Sam Vilain" <sam@vilain.net>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:57:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Xwx-0007ml-Rs
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbYFCO4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbYFCO4O
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:56:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:61861 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbYFCO4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:56:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1050000fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=y8jBzVPrQF6W51XbhDGr3/iztKKDT+UIOuSp23baWLM=;
        b=E8NdXCKIvqUDZ6rBESOXy3Wo4fwl+pbb12+NhLn5r4VS8kO6RqRrbsR52uB7bcCzDq5pab4mMF1nYjHmcEsnJPGChh6f10pQ4bd38f2P0bul9wln7qAGs+XIHR6c+EofC4gtkiqjkmXXo17q4kmVHSScrfFxwGBz2tPnSF3PeTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O+W0BvOpmBARG8QHhYLhKXF9vn8l1349mQDHSABZV/9UGti8t0d+EdfcOfCZeyAmtvxwk6viEbLt1gwEHKRtzKbFctRuqc7yliQS+zWSj4R7Qgt64xmjFOYsuXpyJluTAN1CC2BLkyscYTWK+DQ1pPBHm0nOpV4lVX4va+Q35aM=
Received: by 10.86.53.8 with SMTP id b8mr1406113fga.8.1212504968026;
        Tue, 03 Jun 2008 07:56:08 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id 3sm103233fge.3.2008.06.03.07.56.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 07:56:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0806030740td820c52ve45619812313776c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83671>

Rafael Garcia-Suarez wrote:
> 2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>>> Shameless plug : the sources for perl 5 are currently being kept in a
>>> perforce repository. There is a rough web interface to it at
>>> http://public.activestate.com/cgi-bin/perlbrowse with excellent blame
>>> log navigation features (including navigation against p4
>>> integrations).
>>
>> By the way, what is the difference between '<<' links and 'br' link
>> in the above mentioned annotate/blame interface?
> 
> "br" navigates to another branch from which this file has been
> integrated (in p4 speak.)

Does it mark merge commits then? Or perhaps branch points?  What
does "branch from which this file has been integrated" mean in git
speak (in the terms of DAG of commits)?


If the history of a file looks like this

       ....*---*---A---M---C...
                      /
           ....*---B-/               

and the line comes from "evil merge" M git-blame would return M as
blamed commit.  If the line comes from one or the other branch, from
commit A or B, it makes I think no difference to git-blame; git tries
to be "branch agnostic" (no special meaning to first parent; well,
besides rev~n notation and --first-parent walk option).  I guess it
is not the case in Perforce?

[...]
>> [...].  Will you want to use git-diff-tree
>> to mark differences from the version we came from (marked by 'hp',
>> 'hpb' and 'fp' URI parameters), or would you rather extend git-blame?
> 
> I don't know. I'll look at git-diff-tree.

What I meant here, would you plan on extending git-blame, or would you
use patchset (textual) diff between revision we are at, and revision we
came from.  git-diff-tree just compares two trees (and have to have
patch output explicitely enabled).  Sorry for the confusion.

-- 
Jakub Narebski
Poland
