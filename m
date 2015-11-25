From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Wed, 25 Nov 2015 10:43:27 -0800
Message-ID: <CAGZ79kaCNT06mAGQbHNgZmdBQUyxGFTFA2Y2FXvG2UG+P7s2kg@mail.gmail.com>
References: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
	<1447461987-35450-1-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, peff@github.com,
	Junio C Hamano <gitster@pobox.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:43:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1f2Q-0002VA-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 19:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbbKYSn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 13:43:29 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36169 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbKYSn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 13:43:28 -0500
Received: by ykdr82 with SMTP id r82so65512944ykd.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TlUkcMxf0ud9iSQkZUOQ+YlFj/LzdAyYnO8xIzPGFn0=;
        b=jvCQ1eWzjbRJiTORBDn3lm20BK6VZIA9lFo3T5ZmIxM+lUJ1NF+eRZGSpEFMIdJa2A
         KLWmMi47yEQ3YaN+UpucwtzI4iPhCYRcL60uOvq0+/JlWyPDaSdxecdmQckPUSvRKK3R
         0YoGSk4qwHgny3ptYW/+jHsOT4/EjaQi01ggdad3LG84TRM6QORh/C9w1gW8oXLaQOMJ
         0+ZLzeR0B9UZO+03oIifTrYgmtFlywdGniiMzybon3cLPvezb9lDARMRTXrf0hsZas4F
         7xnwQQWzJRm/dKuoEv8eeaUqolIJW7f2BXUXuhbr0FOgifYyFx31wIcW774xOHrMrwoU
         uqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TlUkcMxf0ud9iSQkZUOQ+YlFj/LzdAyYnO8xIzPGFn0=;
        b=dEAhHKNQLQNRJKUv2QgdUqOyJZYmiVux3ZzpTYd3jbA28MWBRxAUEZjKIjtpiY5cez
         Zi7s/nr1ov4PNfurJ6uypUG4rCVEj+uujt0atW2FUtJbxrhFbjYaiI7qMDv2wWsJ3nYW
         QCOjFjH9bL85ZNa0YKnPJPtflg6eSrtsJXDljEm/24+gdS3YXSuI8/QUF2q/BNigEmRH
         8PRtcSvQlJ4IrPhXjJvKoqwhHdDBXCq2j8JA2JvpkJBISpYRLcnnKxbGOtOiuLa141lI
         XbDUbjCcxSzOOfvDEed7LxW05p8Esrzo69sCg9Oi5Kt+W8fGDQKuv7HfysoG+F2uIdK2
         t8oA==
X-Gm-Message-State: ALoCoQnycwSyyJLKwgbXobt++HHRQWLyhb0GvUnTJEFoLvF54SG7hTaKO5kF38SHO3c0+a/p2l7A
X-Received: by 10.13.235.135 with SMTP id u129mr37305821ywe.48.1448477007491;
 Wed, 25 Nov 2015 10:43:27 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 10:43:27 -0800 (PST)
In-Reply-To: <1447461987-35450-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281727>

On Fri, Nov 13, 2015 at 4:46 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
>                 return "no corresponding .idx";
> -       case PACKDIR_FILE_IDX:
> +       else if (seen_bits & PACKDIR_FILE_IDX && seen_bits ^ ~PACKDIR_FILE_PACK)

Did you intend to use
    (seen_bits & PACKDIR_FILE_IDX && !(seen_bits & PACKDIR_FILE_PACK))
here?

I was just looking at the state in peff/pu and it still has the xor
variant, which exposes more
than just the selected bit to the decision IIRC.
