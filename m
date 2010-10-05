From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] do not depend on signed integer overflow
Date: Tue, 5 Oct 2010 09:26:26 +0200
Message-ID: <AANLkTimdaghq5_vcb+7Anh_05oLJUbZuNXU47YWdBudq@mail.gmail.com>
References: <1286232552-5244-1-git-send-email-kusmabite@gmail.com> <alpine.LFD.2.00.1010050012490.3107@xanadu.home>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 09:26:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P31vJ-0004Uj-S1
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab0JEH0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 03:26:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52720 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab0JEH0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 03:26:48 -0400
Received: by ywg8 with SMTP id 8so93123ywg.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=8PiUEGuzBAzq+EFqo/oJS7uQ/8NPE43EgLG9lr/FnMY=;
        b=buG6LXIY5PqN9OEG1DlFG6KiFaph98H3OTrnbqhHzesS7RYohRGkyBUpuvsBj8ITd4
         eOI3yozA3mtGUltgfwwnaoo/WjhAUCRfB4TMVPXdfbaFfH9RG0t8pcyb1nvNTvvVdagQ
         K6duTiM1bNN8/llD6TfCUdsY1BXIIbsbRXRH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=HHtUkQgIa38zXp/WvQ6MJv7oh0hi/vlSXaRx7JjSPk62u9liS4JtpLZ0rBuaqlaHkn
         W6SRBokB4dI5ikAmiy2dWI+0+Ezcv/t5NOIDDs72tIRiGx/3GKLfnLtcGlInd9nBGI9Z
         EF0u2+ttVEUZ5GviAcW9Cjps+Im/pYVS4GpT4=
Received: by 10.236.109.170 with SMTP id s30mr10214978yhg.3.1286263607200;
 Tue, 05 Oct 2010 00:26:47 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Tue, 5 Oct 2010 00:26:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010050012490.3107@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158171>

On Tue, Oct 5, 2010 at 6:17 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 5 Oct 2010, Erik Faye-Lund wrote:
>
>> Signed integer overflow is not defined in C, so do not depend on it.
>>
>> This fixes a problem with GCC 4.4.0 and -O3 where the optimizer woul=
d
>> consider "consumed_bytes > consumed_bytes + bytes" as a constant
>> expression, and never execute the die()-call.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>
> I like this. =A0Please also fix the similar case in
> builtin/pack-objects.c:write_one().
>

Thanks for pointing that one out. For some reason GCC didn't warn
about that instance - perhaps it's optimizer missed the case due to
going through that pointer?

I've just resent a version with that fix-up.
