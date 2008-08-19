From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3 v2] add new Perl API: Git::Repo, Git::Commit, Git::Tag,
 and Git::RepoRoot
Date: Tue, 19 Aug 2008 17:06:26 +0200
Message-ID: <48AAE172.3000307@gmail.com>
References: <1219088389-14828-1-git-send-email-LeWiemann@gmail.com> <1219088389-14828-2-git-send-email-LeWiemann@gmail.com> <7v8wutkcx4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSo1-0006Of-TK
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 17:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbYHSPG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbYHSPG1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 11:06:27 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:7964 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbYHSPG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 11:06:26 -0400
Received: by gv-out-0910.google.com with SMTP id e6so687982gvc.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=eqz17Xz1NES0AkX1SGgizC35ENXRYC+/rq60t+Taj6o=;
        b=u8LEP2egi1oFTDkL8+6kdnlkutXEP3aqlSyzhpA9w7FJnx0Lx2t9QTHEveBLA8ArrJ
         uGOyfIzSokLZkes6Hq552VlVF23CY2Thn9b7Quftd9/dTQv2QR+VamJSiWueamz7w1sl
         o+bVr55INVw+wrmkGzYz4WJLYMtyAYAOo9TzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=dnyYq8oUKgIJINhfesGiKpxfYb3X0tP4tpJjLGiTxyApzvFIGqScTbccOjzeX58mrG
         NOHbEOjlozNo9vG9mVlhwAhu7afSYaCqiubckg/46zYxSxd0mIKYqWD5NIMWdeqYlsrH
         E0aqlDlIp0ozOHnuURTVm1dm5l2LP26Lh5boY=
Received: by 10.187.238.1 with SMTP id p1mr491058far.67.1219158384794;
        Tue, 19 Aug 2008 08:06:24 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.210.90])
        by mx.google.com with ESMTPS id 21sm221907fkx.13.2008.08.19.08.06.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 08:06:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <7v8wutkcx4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92875>

Junio C Hamano wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
>> +The author, committer and message methods return Unicoded strings,
> 
> Unicoded?

Fixed. :)

>> +# Auxiliary method to load (and parse) the commit object from the
>> +# repository if it hasn't already been loaded. [...]
>> +sub _load {
>
> Aside from seeming repetitive and quite similar to Git::Tag::_load(),

I didn't see a clean way to extract common code since there are
differences in how some headers are parsed (e.g. 'parents' is an array).

> I have to wonder how parent rewriting and grafts come into the picture.
> Git::Repo::get_object is just a cat-file which means you are ignoring any
> grafts.  As a design decision it is fine, but it needs to be documented.

I'm not sure if I understand grafts correctly, but would something like
the following piece of text in the documentation for
Git::Commit->parents cover it?

"Note that this method does not currently respect grafts.  Hence, if you
are operating on a repository that contains grafts (e.g. a shallow
clone), the commit objects returned by the 'parents' method may not
exist in the repository; your program will die if you call an attribute
accessor method (such as 'author' or 'message') of any parent of an
object with grafted parents.  Thus, if you want your program to work
with shallow clones, you will have to check the .git/info/grafts file
yourself before accessing any parents.

You must not rely on this behavior.  In the future, the 'parents' method
may return the grafted parents instead of the parents recorded in the
commit object."

> Also if you run "per path history" using "rev-list $head -- $path" to
> collect commits that touch the named $path, you might want to get
> rewritten parents for each commit and use it in the presentation,

You're referring to gitweb here, right?  (The perl API doesn't use
rev-list.)  I don't think gitweb is currently tested with grafted
repositories at all, but in general it should respect rewritten parents,
since the parse_commit function uses rev-list without the 'raw' format,
and thus it should get the rewritten parents.

-- Lea
