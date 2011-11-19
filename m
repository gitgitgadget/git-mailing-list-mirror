From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Sat, 19 Nov 2011 19:25:33 +0000
Message-ID: <4EC802AD.1060405@ramsay1.demon.co.uk>
References: <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net> <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com> <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com> <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org> <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com> <20111116075955.GB13706@elie.hsd1.il.comcast.net> <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com> <20111116085944.GA18781@elie.hsd1.il.comcast.net> <CACsJy8CYj_s92zG-LnBKtHxV2uaG8-rq-VNJiQYwNJXGKbFeDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:02:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRr7E-0000Hg-P7
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab1KSUCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:02:17 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:61647 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752699Ab1KSUCP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2011 15:02:15 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RRr77-0002ds-WH; Sat, 19 Nov 2011 20:02:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <CACsJy8CYj_s92zG-LnBKtHxV2uaG8-rq-VNJiQYwNJXGKbFeDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185699>

Nguyen Thai Ngoc Duy wrote:
> On Wed, Nov 16, 2011 at 3:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Nguyen Thai Ngoc Duy wrote:
>>
>>> Or perhaps
>> [...]
>>>  - git_path(const char *path) maintains a small hash table to keep
>>> track of all returned strings based with "path" as key.
>>>
>>> Out of 142 git_path() calls in my tree, 97 of them are in form
>>> git_path("some static string").
>> The main bit I dislike about patch 3/3 is that constructs like
>> 'unlink(git_path("MERGE_HEAD"));' are not actually unsafe
> 
> Well, we can create wrappers (e.g. repo_unlink(const char *) that
> calls git_path internally). According to grep/sed these functions are
> used in form xxx(git_path(xxx))
> 
>      16 unlink
>       8 file_exists
>       7 stat
>       6 fopen
>       5 rename
>       5 open
>       4 unlink_or_warn
>       3 safe_create_dir
>       3 adjust_shared_perm
>       3 access
>       2 xstrdup
>       2 safe_create_leading_directories

This one at least, maybe others, is unsafe on cygwin. Indeed it causes
a test failure in t3200-branch.sh; patch is on it's way ...

ATB,
Ramsay Jones
