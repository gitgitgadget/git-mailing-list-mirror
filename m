From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] revert: Separate cmdline argument handling from the
 functional code
Date: Fri, 13 May 2011 04:44:49 -0500
Message-ID: <20110513094449.GB30396@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-5-git-send-email-artagnon@gmail.com>
 <20110511114909.GE2676@elie>
 <20110513090923.GB14272@ramkum.desktop.amazon.com>
 <20110513093501.GE14272@ramkum.desktop.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:45:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKovd-0001vs-9S
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab1EMJo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 05:44:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56375 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162Ab1EMJoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 05:44:55 -0400
Received: by iwn34 with SMTP id 34so2127155iwn.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 02:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=J2iYfMDxY0kprmba6EF9lFb1UeJMDCkbzEVJdFp1jkw=;
        b=VLZIybKf3jmwrGjJyp8Zg/OI24CAjmRFWF0x+3btiHIVS8JHKbIX1GbeGFClBEsybl
         h1B0YuVDyFf0XYQ+V4RG75JC+OzP0Z7HnxhNOigksyK93Slce7UfGTUJB7RI658AcoQd
         F/YZddmejVYS3rTb/GO3CgiCLdj2ht9vd7rIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u7HP4pecZh5/SUmLAHtmXmJKjLqFNHZ+DcgzRfs9XCmjquKu+HVgVOKXVw5wIucxUo
         +7Sg9qCIwb6hikWwNcuz+82gUVKEBgYbOJ81jCypeTRIRKKLl1iX2dBkTZILxfKBk3OY
         ayWQuT9qbiHfoxGCe0J7P8tMNr+BcI0dE8O9E=
Received: by 10.42.29.200 with SMTP id s8mr1379083icc.266.1305279894776;
        Fri, 13 May 2011 02:44:54 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id uf10sm822684icb.17.2011.05.13.02.44.53
        (version=SSLv3 cipher=OTHER);
        Fri, 13 May 2011 02:44:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110513093501.GE14272@ramkum.desktop.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173518>

Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra writes:
>>> Ramkumar Ramachandra wrote:

>>>> +++ b/builtin/revert.c
>>>> @@ -603,19 +603,12 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static int revert_or_cherry_pick(int argc, const char **argv,
>>>> -				struct replay_opts *opts)
>>>> +static int pick_commits(struct replay_opts *opts)
>>>>  {
[...]
>>>> -	setenv(GIT_REFLOG_ACTION, me, 0);
>>>> -	parse_args(argc, argv, opts);
>>>> -
>>>>  	if (opts->allow_ff) {
[...]
>> Nice catch! Yes, GIT_REFLOG_ACTION should be in pick_commits.
>
> Er, I mean in do_pick_commit.  Right?

It seems somehow cleaner to set the envvar once in pick_commits,
assuming do_pick_commit is a private function that won't be exported.
But either way sounds fine to me.
