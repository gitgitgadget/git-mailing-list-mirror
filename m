From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 14:15:37 +0200
Message-ID: <94a0d4530902140415j4168d09dh8abac0d6eba0b8cf@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
	 <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 13:21:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYJWX-0003pd-LL
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 13:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbZBNMPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 07:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbZBNMPk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 07:15:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:15491 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZBNMPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 07:15:39 -0500
Received: by fg-out-1718.google.com with SMTP id 16so43764fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 04:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LodV08K5uznKF7XKvnNzZGsmtCvyskm1RwfYKYYf8o0=;
        b=D3+WTliEorR4Fq48JV2hWC4xSeaCCvjobKh5tYzSK3H+P8/zJpVsLKB5WZ9RXz9kVH
         W6O4vtQTrsc/LMTOaohmtbENmXUkSCKvOH77hterkD92hYKICTJ+gsg67O/mFZd7aM18
         AjBOBvSEwPQuEFEt65GSjSpyxcXjjpyR2h6Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AfNXybRERwquJ5hsZdVhlnOdg6lLvkCqDX4QGXCkuCXme7jzYPUi5TfK5Ec8PV1YHC
         Y1qLoffkoZ9YNk3EDlusGVIYa4LvKrITF6V5EDsWNUcg+t+uGwu/btI4dlZpikRMM4+B
         iD+Gelt4KjgyeEgToKmg3QECUs/W8wMgysHbA=
Received: by 10.86.100.19 with SMTP id x19mr293320fgb.29.1234613737831; Sat, 
	14 Feb 2009 04:15:37 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109868>

On Sat, Feb 14, 2009 at 1:40 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 14 Feb 2009, Felipe Contreras wrote:
>
>> Then why are you asking?
>
> Out of curiosity, I guess, as it would happen to answer my curiosity as
> well.
>
>> This is more a "I would like to increase the chances of my patches
>> being accepted so I'd do some chores to gain the trust of some
>> developers", and Johannes Schindelin was pushing me to do this.
>
> Heh, I'll gladly take the blame for that!
>
> Note that in contrast to Junio, I think "git config" is a chimera between
> plumbing and porcelain, and would benefit tremendously from a nice help.

I agree on that.

>> >> +static int type_int, type_bool, type_bool_or_int;
>> >
>> > You can have either (no type specified, int, bool, bool-or-int) at the
>> > end.  Using three independent variables does not feel right.
>> >
>> > Hint: OPTION_SET_INT.
>>
>> That definitely makes things easier, it would have been nice to see an
>> example of this; I didn't knew it was there.
>>
>> The only problem is that --bool and --int would be possible in the
>> same command and there would be no way to output an error, but I guess
>> that's not a big problem.
>
> I think that is okay.
>
>> >> +     else if (do_add) {
>> >> +             if (argc > 2)
>> >> +                     die("Too many arguments.");
>> >> +             if (argc != 2)
>> >> +                     die("Need name value.");
>> >> +             value = normalize_value(argv[0], argv[1]);
>> >> +             return git_config_set_multivar(argv[0], value, "^$", 0);
>> >
>> > This part did not lose argc error checking, but...
>> >
>> >> +     }
>> >> +     else if (do_replace_all) {
>> >> +             value = normalize_value(argv[0], argv[1]);
>> >> +             return git_config_set_multivar(argv[0], value, (argc == 3 ? argv[2] : NULL), 1);
>> >
>> > You do not check argc here (nor in many "else if" below) to make sure you
>> > have sufficient number of arguments.  "git config --unset" is now allowed
>> > to segfault, and "git config --unset a b c d e f" can silently ignore
>> > excess arguments for example?
>>
>> Yes the arguments check need to be revised.
>>
>> My hope was somebody would review this and suggest a clever and
>> generic way of doing this. Perhaps a util function check_min_args, or
>> maybe something in parseopt that receives the number of args?
>
> Maybe a helper, yes.  Something like:
>
>        static void check_argc(int argc, int min, int max) {
>                if (argc >= min && argc <= max)
>                        return;
>                fprintf(stderr, "Wrong number of arguments: %d\n", argc);
>                usage_with_options(config_usage, config_options);
>        }
>
> Of course, this assumes that config_usage and config_options are global...

Cool.

I've sent a new patch with this helper (a bit modified), and all the
changes Junio suggested.

I still have a few doubts:

1) --list when no config file is given uses all the config files,
wouldn't it make sense to have a --repo option?

2) --get-colorbool prints "true" or "false" only when there are two
arguments, is that correct or should stdout_is_tty be used instead?

3) should the documentation be updated for the --get-color* options to
use 'slot' instead of 'name'?

-- 
Felipe Contreras
