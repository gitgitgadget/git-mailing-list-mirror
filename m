From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 10:50:56 +0200
Message-ID: <1m7p7z9.36ajnyli8ph2M%lists@haller-berlin.de>
References: <xmqq380o593i.fsf@gitster.dls.corp.google.com>
Cc: dev+git@drbeat.li (Beat Bolli), git@vger.kernel.org,
	paulus@samba.org (Paul Mackerras)
To: gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Fri Jul 17 10:58:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG1TL-00024k-HM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 10:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbbGQI6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 04:58:10 -0400
Received: from server90.greatnet.de ([178.254.50.90]:34530 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbbGQI6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 04:58:07 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2015 04:58:07 EDT
Received: from [10.1.0.140] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 4DA5D2B400A;
	Fri, 17 Jul 2015 10:50:57 +0200 (CEST)
In-Reply-To: <xmqq380o593i.fsf@gitster.dls.corp.google.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.10.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274062>

Junio C Hamano <gitster@pobox.com> wrote:

> Beat Bolli <dev+git@drbeat.li> writes:
> 
> > When referring to earlier commits in commit messages or other text, one
> > of the established formats is
> >
> >     <abbrev-sha> ("<summary>", <author-date>)
> > ...
> > +proc copysummary {} {
> > +    global rowmenuid commitinfo
> > +
> > +    set id [string range $rowmenuid 0 7]
> > +    set info $commitinfo($rowmenuid)
> > +    set commit [lindex $info 0]
> 
> 7 hexdigits is not always an appropriate value for all projects.
> The minimum necessary to guarantee uniqueness varies on project, and
> it is not a good idea to hardcode such a small value.  Not-so-old
> Linux kernel history seems to use at least 12, for example.
> 
> I believe that the "one of the established formats" comes from a
> "git one" alias I published somewhere long time ago, that did
> something like this:
> 
>   git show -s --abbrev=8 --pretty='format:%h (%s, %ai' "$@" |
>   sed -e 's/ [012][0-9]:[0-5][0-9]:[0-5][0-9] [-+][0-9][0-9][0-9][0-9]$/)/'
> 
> where the combination of --abbrev=8 and format:%h asks for a unique
> abbreviation that is at least 8 hexdigits long but can use more than
> 8 if it is not long enough to uniquely identify the given commit.

For the intended use case of this feature (referring to earlier commits
in commit messages), guaranteeing uniqueness isn't sufficiant either.
What is unique at the time of creating the commit might no longer be
unique a few years later.

So one strategy would be to add one or two digits to what %h returns, to
give some future leeway; or rely on the user to configure core.abbrev
appropriatly for their project; or just make the hard-coded value
configurable, as Hannes suggests.

FWIW, a discussion of this that I find useful can be found here:
<http://blog.cuviper.com/2013/11/10/how-short-can-git-abbreviate/>.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
