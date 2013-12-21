From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH] wt-status.c: disable those distracting
 -Wformat-zero-length warnings
Date: Sat, 21 Dec 2013 15:09:22 -0500
Message-ID: <CAJYzjmc2Mvr=d9CtR_KCPF3Msy6vJWVO7_pE7FGNL5p=2Bn6cA@mail.gmail.com>
References: <1387554301-23901-1-git-send-email-naesten@gmail.com>
	<20131221094202.GA32622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 21 21:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuSrZ-0000NB-D5
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 21:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab3LUUJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 15:09:24 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:58026 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab3LUUJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 15:09:23 -0500
Received: by mail-la0-f47.google.com with SMTP id ep20so1681874lab.34
        for <git@vger.kernel.org>; Sat, 21 Dec 2013 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e2YPIZaL+ZlpFsqCeKnPaTjVUMSTLydlO1rTI05qTRo=;
        b=xtSM6bYMVutrN0TY8ZH3rEVDYKuw01E5v+s+AwfvkUH6TCYvgW67hRQTXWR6WLvVR6
         RSh0f6otmtIU1nasIk7DkH61+an92GAd0BQuS9G8WG/gJHSyxGtlxkspc5H41nPfgkdO
         IJgGEUs2hWeKDBXvdHIlupncAaflUoiAtf6e7OagAggew/rhB2tOwY3bG4CH+yhqpHbK
         w2ubN6dDE2KBbstitxW74bvAl79W1+VZUq/Ui20KFF+zCbVrSwZl/4D9537iEWdTuAgW
         46APehDLs2/64I2TpHHvU4tbLt4KPAV2k6EITwUTNdENzGe0r/h1EAo0qx5THw4SZq6D
         mVrg==
X-Received: by 10.112.158.231 with SMTP id wx7mr4397901lbb.27.1387656562196;
 Sat, 21 Dec 2013 12:09:22 -0800 (PST)
Received: by 10.112.133.227 with HTTP; Sat, 21 Dec 2013 12:09:22 -0800 (PST)
In-Reply-To: <20131221094202.GA32622@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239627>

On Sat, Dec 21, 2013 at 4:42 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 20, 2013 at 10:45:01AM -0500, Samuel Bronson wrote:
>
>> These warnings don't really seem to make much sense for this file.
>
> Agreed, though the advice so far has been to put -Wno-format-zero-length
> in your CFLAGS.

Yes, auto-detecting acceptance of this flag and using it automatically
might be a reasonable approach as well, but I thought this warning
might potentially be useful WRT other printf-like functions.

>> +/* We have good reasons for using zero-length format strings, and
>> + * there's unfortunately no way to turn this off on a per-function
>> + * basis ... */
>> +#pragma GCC diagnostic ignored "-Wformat-zero-length"
>
> Are other compilers happy to ignore this pragma? I guess we could wrap
> it in an #ifdef, if so.

I assume you meant we could use an #ifdef if *not*?

> It's also really not about this file in particular. The whole concept of
> format-zero-length is questionable, as it ignores the concept that a
> format function might actually do something useful with an empty format
> (e.g., by adding boilerplate, or having a side-effect). It's just that
> this file is the only one that happens to do so.

Hmm, I think I saw one other instance of this warning, actually, but
it didn't seem worth adding the pragma to a file for just one warning.

> Annotating the _function_ to say "it's useful to pass an empty format
> into this function" would make sense, but as you note, there is no way
> to do that.

I made a note about this at
<http://gcc.gnu.org/bugzilla/show_bug.cgi?id=47901#c9> (comment #9 on
"-Wall should not imply -Wformat-zero-length by default")

> So I dunno. This seems like it does not quite specify what we want to
> say as well as just "-Wno-format-zero-length", but it is more convenient
> in practice (because we take care of it in the source code, rather than
> relying on the user's build settings).

Yeah.
