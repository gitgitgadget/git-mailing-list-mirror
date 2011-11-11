From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] i18n: add infrastructure for translating Git with gettext
Date: Fri, 11 Nov 2011 11:34:27 +0100
Message-ID: <CACBZZX5VNM46qA9QZmdA2zYq+=w4Y69_74AffRgjvsRtj95kdg@mail.gmail.com>
References: <1320970164-31694-1-git-send-email-avarab@gmail.com>
 <1320970164-31694-2-git-send-email-avarab@gmail.com> <m31utfnedi.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 11:34:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROoRi-0003Ec-GF
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 11:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab1KKKeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 05:34:50 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49037 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab1KKKet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 05:34:49 -0500
Received: by bke11 with SMTP id 11so3099327bke.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 02:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zmPzEVIlqpj/+cIxF7T1o2XHOZ/R3KcVWKXhj6/xH3M=;
        b=bo0D51HZTTaTqX2ms386ZwPff16rZ12iTJ/HVTwSwXW9Fahv6ZkbCU+Dcuo7x1MUQg
         c+53v4mk2Pudmstpb7YxfYSfFn/gjuVec6sqd9FTGlvxAS7dNmX6w7xqDMul8XG75QwZ
         t8jyqW4FwpxHmIglYVQdP71GLNjdE+7jv2g70=
Received: by 10.204.9.205 with SMTP id m13mr7701511bkm.32.1321007688120; Fri,
 11 Nov 2011 02:34:48 -0800 (PST)
Received: by 10.204.118.67 with HTTP; Fri, 11 Nov 2011 02:34:27 -0800 (PST)
In-Reply-To: <m31utfnedi.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185262>

On Fri, Nov 11, 2011 at 11:27, Jakub Narebski <jnareb@gmail.com> wrote:

>> I originally tried to detect if the system supported `echo -n' but
>> I found this to be a waste of time. My benchmarks on Linux, Solaris
>> and FreeBSD reveal that printf(1) is fast enough, especially since
>> we aren't calling gettext() from within any tight loops, and
>> unlikely to ever do so.
>
> Didn't we decide that the only sane way to handle eval_gettext
> is to provide minimal implemetation in the form of external command?

This comment is a bit out of date and probably shouldn't be in the
commit message. But it doesn't have to do with eval_gettext. I mean at
one point I tried to change the fall-through wrapper from:

    gettext () {
	    printf "%s" "$1"
	}

to:

    gettext () {
	    echo -n $1
	}

But found it to bee too troublesome with various echo implementations
and just not worth it for the complexity.

But yeah, for eval_gettext() we need an external program, which we
already have in git.git as git-sh-i18n--envsubst.
