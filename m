From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sun, 9 Jun 2013 13:27:00 -0500
Message-ID: <CAMP44s0xQajOE=w-j4u=sQF71U9CyKj48ZqJ6s4O7zmUTFa__Q@mail.gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
	<1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
	<51B31651.6020307@lsrfire.ath.cx>
	<CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
	<51B32FFD.5070302@lsrfire.ath.cx>
	<CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com>
	<51B35414.1090101@lsrfire.ath.cx>
	<CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com>
	<51B36849.3030608@lsrfire.ath.cx>
	<CAMP44s1ffOUd3DkphHAj8ZmovBazPFdMgtvEptR6kW9+ZMLLjA@mail.gmail.com>
	<51B3E44C.4030304@lsrfire.ath.cx>
	<CAMP44s0RqtoP8iHZ+rEqPDKSLxZLESS8qKFhb2vzSd7-mtKreQ@mail.gmail.com>
	<51B4BD9F.6070107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:27:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkKa-00030T-W7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab3FIS1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 14:27:03 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:42965 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab3FIS1C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 14:27:02 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so706474lbd.15
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3VwG0vbebrVGzVDMZpsv33Ll9MLYjg7eDFZoWDHQ+mQ=;
        b=p4wDRmPMkyQxU+2SdBu7nHHrK/BtodUndAGax3G8I74jCnNuueLE+UfvWuxr9TyKF1
         fzLRYbp1R5iOwZmQjwk6i8mtyE3uqX2sa0DXHLMabCE8xhnYI9K0M/i3jk0KmSzQ25HI
         bNp+8K67EXkUONZ2nrK9/wpekxkYg44WNKd0etKQgqcbx//HLI27vILVxoW8wwpQcP99
         azUuOQBhhgbKp/Zf+S6aToHF+HPcXuBRq6bfozDE7i4YpDmzUKJA/bBtCq6AJ9eNv0G+
         +oJ/TWYJ5WSQAzWXXDBJyefIPF1+gEJI2zzIRaYxv55Bd8Zqa/9i7KD8pr5McgZ7fDqm
         il1w==
X-Received: by 10.152.27.170 with SMTP id u10mr3376708lag.45.1370802420459;
 Sun, 09 Jun 2013 11:27:00 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:27:00 -0700 (PDT)
In-Reply-To: <51B4BD9F.6070107@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227086>

On Sun, Jun 9, 2013 at 12:38 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 09.06.2013 04:25, schrieb Felipe Contreras:

>> It doesn't. I thought you already silently agreed that nobody would
>> ever find that leak, as they haven't found the hundreds of leaks tha=
t
>> plague Git's code.
>
> Nah, I explained non-silently that leakage was a design decision for
> short-running commands that allocate memory, use it and exit.  Reusin=
g such
> code without freeing allocated memory between runs explicitly turns a=
 "good"
> leak into a "bad" one, as we saw with cherry-pick --stdin.

git cherry-pick for multiple commits is already there, such a leak
would be a bad one, and nobody would find it. Valgrind doesn't know
about your concept of "good" leaks, all that you see is tons of leaks.

> Any more sequences that we need to guard against, or counterexamples?

I don't know.

>> In the meantime, just in case, the only sane thing to do is free the
>> entries rather than leak.
>
> I consider not plugging a leak which we don't know how to trigger wit=
h
> existing code even more sane.  Yay, circles! ;-)

There's absolutely no benefits to leaving the potential leak.

> Let's take it step by step: Once the known leak is plugged we can wor=
ry
> about the unknown ones.  I'll send small patches.

Go ahead. I'm not interested any more.

--=20
=46elipe Contreras
