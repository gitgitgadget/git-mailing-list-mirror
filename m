From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 12:20:11 -0800
Message-ID: <CAGZ79kaq25tD5y3r6FY_5X6xUz9b7Hb8h1KBbVdhsX5zPN_7Dw@mail.gmail.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
	<1421893929-7447-6-git-send-email-sbeller@google.com>
	<54C0F41F.2080705@ramsay1.demon.co.uk>
	<CAGZ79kZnECcGOWKr4JLpF5zh68+L8XX7yYntyZDJTbZ5cLD50w@mail.gmail.com>
	<54C154C0.9020708@ramsay1.demon.co.uk>
	<54C15A00.9000706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEOEk-0008Nz-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbbAVUUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 15:20:14 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:65204 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbAVUUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 15:20:12 -0500
Received: by mail-ig0-f171.google.com with SMTP id r10so2545526igi.4
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 12:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VpfgLPHHQ0bheANcuG3UbbvDraXexbXjb3RKRkv3NWg=;
        b=DFSRYKMDHoyEbjWZMOjBl2sGkAFevl1r9rACWhV1RLMeyUEv2/IqrEzEJVEy/yfaXE
         JWBjtpxcLINsKb8lKYPpEn793zKGP4JJSQoRCtv1JDHbRJX7ep9pTx6DTSBY3s339/Sh
         pES8PJgxC+IGO29NrsQH8QmI/YXQRtFjiraNukjxIy5w4JdEfvqRyDMe+XfvZZygJnxd
         iPJ5uhKwTL2OP8FjM4mrmrGeH3mm3rLANXkOBib9c3MbXGVMd9833bQU7Alvn/QhZ/HD
         SkKr9DpBEALfGhW3kxfrd/16uhkB+d4FIWcmXNOT6QIFWNC54jSVpFFPXAc0RkH5prQV
         NGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VpfgLPHHQ0bheANcuG3UbbvDraXexbXjb3RKRkv3NWg=;
        b=MBU0vYJOU+/wfETS1U1yM3h+uRxXnbKj9AZ1xBNrm6X9qI63rZ9EpQYqegfmOaej1l
         W2vPPyJ92joACMB2p96z/Ir6/mUJWWh5zfwTd4YFTw5sSRoNwy8mXpvVos4deuaaM9td
         fTRqHJq8g/nXfhyFJNK7+7inEO4hbW4jjgSmRyuiW3eP+33Amjtvd/MfM9oC0G1inIOn
         2xVUXmn+VI3O0pMg7cEj5srGSN9wn/PMADCqDBg3JnJIOhymFHbazqLsEsbwGQrX3tWC
         wSNqj/fHyV38Vdyqrn6DxWdKyfNFqapbHdHmRCNMRhzErjG4BCeoUkJNtg09BUbqk2Oe
         qDsA==
X-Gm-Message-State: ALoCoQmYa7knuThgtAlNJZbN7A8IDwEZQLLhbs42/RY2Q21YGt2OdJMKa04flINQv85YU8Qm+O4s
X-Received: by 10.42.71.194 with SMTP id l2mr5335223icj.71.1421958011896; Thu,
 22 Jan 2015 12:20:11 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 12:20:11 -0800 (PST)
In-Reply-To: <54C15A00.9000706@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262867>

On Thu, Jan 22, 2015 at 12:13 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Notice the [-Wextra] warnings above. ;-)
>
> ATB,
> Ramsay Jones
>

Thanks, I put that into my config.mak
Though recompiling the whole project yields

      4 [-Wempty-body]
    477 [-Wmissing-field-initializers]
    966 [-Wsign-compare]
    899 [-Wunused-parameter]

so maybe I'll disable it again when I think it's too much output.
