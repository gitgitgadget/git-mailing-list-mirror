From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 1/2] pull --rebase: add --[no-]autostash flag
Date: Sun, 28 Feb 2016 20:28:49 +0800
Message-ID: <CACRoPnT6Yc_vfrYvzKctL1dDkZCzme-4emLF0MysJq4f_H2OvQ@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<xmqqk2lqeyzv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mehul Jain <mehul.jain2029@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 13:28:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa0T2-00034E-QW
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 13:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbcB1M2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 07:28:52 -0500
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35197 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbcB1M2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 07:28:51 -0500
Received: by mail-lb0-f195.google.com with SMTP id h2so5058569lbs.2
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 04:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=WPIHoR7+o4IQwSU9oBWtKKoAPLTWAndl0bA9QeBbjyI=;
        b=H2GmsxEdaYaY/+YaCD6C7kDhd32piP4f+/O1pr5T7KGwTjyUGY3K8/UDo50WgxYlSi
         u+YarXNlQWi5yhEgUW4s7KIiHsq5rzqpI4nf8UfnZ6Bsd6dWnVqWZJ1NPzqZ0H7VsG2a
         KquzReaatE76vm7sYx4L/MctFpb4ARPSV6ho4ZxXL4+rYZ+82UvHMPp/GRClERtBbmNE
         XkbSk4avDTypM5shlh0yiJNLzQ+bmZ0+8i91aTG2oDoEwRQANm8nf4PdPEWMnkK0keTB
         wLe/0HrhyXN9rZHkYdbEj3E1wVsGVf6cZPWizFL66vMmkV+V1ZByMB3b6TEUy9OG0Ion
         XWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WPIHoR7+o4IQwSU9oBWtKKoAPLTWAndl0bA9QeBbjyI=;
        b=RlQSynz+L5t/uGpUZVQy3Yi8TxwIhr7Z9+RP+BPd1/gOikUDqHtwDy0WdrLCs0rk+C
         Kb9URpicFbPX1wA3tmXAEgimrENCmUuurJw/uX7HQdpsJPRRsYhkldzJ2g1++ubmjkOY
         2s8V+1HwuqY5qeHuLbN0FvJ1TGTlD3qqiiiY3nUid+aSJMrwQ75eKVDlpyqxzi3T1WRF
         2ILRFax76PJ9td8zYc+kDPzGCRVGA1/30GEM7BtQuRNtafxpH+qGzWqcmVvEJKl4rnSC
         YmvABwFAnkPDDDfg9gJkIlTyRDtZWXygjqmIrwGlYymmOJ7HTX5jP3quMOhdQe5GwBsZ
         VCdQ==
X-Gm-Message-State: AD7BkJJpbepIa/BL2y+RdXMyZREjru1oGA4v+IyoxXGiZNAKB5x/U7Jna5c8ozRWUYb+0n0haZXC3LQnPkqkqQ==
X-Received: by 10.112.184.133 with SMTP id eu5mr2840652lbc.99.1456662529901;
 Sun, 28 Feb 2016 04:28:49 -0800 (PST)
Received: by 10.112.207.68 with HTTP; Sun, 28 Feb 2016 04:28:49 -0800 (PST)
In-Reply-To: <xmqqk2lqeyzv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287773>

Hi Junio,

On Sun, Feb 28, 2016 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>> @@ -835,13 +841,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>               hashclr(orig_head);
>>
>>       if (opt_rebase) {
>> -             int autostash = 0;
>> -
>>               if (is_null_sha1(orig_head) && !is_cache_unborn())
>>                       die(_("Updating an unborn branch with changes added to the index."));
>>
>> -             git_config_get_bool("rebase.autostash", &autostash);
>> -             if (!autostash)
>> +             if (!opt_autostash)
>>                       die_on_unclean_work_tree(prefix);
>
> I would have expected that
>
>  * a global opt_autostash is initialized to -1 (unspecified);
>
>  * opt_bool() would flip it to either 0 or 1 with --[no-]autostash;
>
>  * existing "rebase.autostash" configuration check inside "git pull"
>    code  gets removed;

Removing the "rebase.autostash" configuration check would bring back
the problem which 53c76dc (pull: allow dirty tree when
rebase.autostash enabled, 2015-07-04) fixed.

>  * and the code that builds "git rebase" invocation command line
>    will do
>
>         if (opt_autostash < 0)
>                 ; /* do nothing */
>         else if (opt_autostash == 0)
>                 argv_array_push(&args, "--no-autostash");
>         else
>                 argv_array_push(&args, "--autostash");
>
> Then when "git pull --rebase" is run without "--[no-]autostash", the
> underlying "git rebase" would be run without that option, and does its
> usual thing, including reading rebase.autostash and deciding to do
> "git stash".  And when "git pull" is run with "--[no-]autostash",
> the underlying "git rebase" would be given the same option, and
> would do what it was told to do, ignoring rebase.autostash setting.
>
> So why does "git pull" still need to look at rebase.autostash
> configuration after this change?

Ultimately, git-pull needs to be aware of whether autostash is active
or not (and this means rebase.autostash needs to be looked at as well)
because if autostash is disabled, git-pull needs to perform the
"worktree is clean" check. And this "worktree is clean" check needs to
be done *before* git-fetch and git-rebase is run.

See f9189cf (pull --rebase: exit early when the working directory is
dirty, 2008-05-21).

Regards,
Paul
