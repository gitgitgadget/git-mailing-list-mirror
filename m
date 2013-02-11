From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 15:27:19 +0100
Message-ID: <CABPQNSaKt6XGwRBMNw1eHNCY-d0TY=63LwcnQsFKdnhA+JTL-w@mail.gmail.com>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
 <vpqobfr9da7.fsf@grenoble-inp.fr> <CABPQNSbYCrdSP5rWbfLX==u--bJpQo6A6sNE46a1RuU-fMDiWg@mail.gmail.com>
 <vpqy5ev7xpp.fsf@grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 15:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4uMr-0003yV-9g
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 15:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab3BKO2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 09:28:01 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45158 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031Ab3BKO2A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 09:28:00 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so7547295ieb.6
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 06:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=x1H+jQ/F7ZYlf3Ea7OhwPVNtkrZEwpBaZvJwHfA0Oww=;
        b=qwPKwx4NhpnOSyx+fHKxOAYkhytDI+iv+oJZqwREkRGlsseDblSXNmPNOnvigBkCsx
         3am9rKDe5tmhlWd+L36nyj6M8WlPwQgAKJfqgw4fV3Y4LAtGPslV9ZFWj9qBjIt6WYli
         b+BiyMR/0YGQFe3edaXOO5I/Hx0ueToiqH+/DEBDpQ1BXcF2E8wPMHD0WhOIhFZVO9wR
         RTXc+je35bcZH5sqKDhi8N4gHmTfOE3AniUc1fsPP3gXzQ/E5yyhYo9hBHFKs7CmPcJ4
         9oRC6BhoE+14ydl4aZ1ushiG4cARvu2i9JXE1MzQJ3nYCqkHifFS5p7k3vLxO/cL7JgR
         6MgA==
X-Received: by 10.50.88.228 with SMTP id bj4mr11809647igb.85.1360592879989;
 Mon, 11 Feb 2013 06:27:59 -0800 (PST)
Received: by 10.64.164.139 with HTTP; Mon, 11 Feb 2013 06:27:19 -0800 (PST)
In-Reply-To: <vpqy5ev7xpp.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216036>

On Mon, Feb 11, 2013 at 3:05 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> But isn't UTF-8 constructed to be very unlikely to clash with existing
>> encodings? If so, I could add a case for non-ascii and non-UTF-8, that
>> simply writes the byte as a hex-tuple?
>
> If it's non-ascii and non-UTF-8, I think you'd want to display the byte
> as it is, because this is how it was entered. IOW, I'd say we should
> keep the current behavior in this case.
>

Yes, you are of course right. We should detect UTF-8, and only in
those cases do anything special. Because the likely alternatives are
other 8-byte encodings (which the terminal already should grok, since
the user was able to input it), or other multi-byte sequences (which
already is broken, and is tricky to handle). So at least we'd only
break in very unlikely cases.

But, I wonder, could mbrlen be used to detect the length instead? It
consults LC_CTYPE to find out what encoding to use, which seems like
it might give the correct answer in all non-corrupted cases... I'm far
from an expert on UNIX-internationalization, though. And this approach
is likely to break on Windows, but I suspect that we can perform some
well-placed hack for it, as we already know that we're doing UTF-8
there.
