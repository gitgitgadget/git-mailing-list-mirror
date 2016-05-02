From: David Turner <dturner@twopensource.com>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Mon, 02 May 2016 16:41:27 -0400
Organization: Twitter
Message-ID: <1462221687.4123.79.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 22:41:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKet-0006P8-8H
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbcEBUlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 16:41:32 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35084 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbcEBUla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:41:30 -0400
Received: by mail-qg0-f53.google.com with SMTP id f74so74839790qge.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9Umfx2q/XCP+aMYDWDv4Y72De0TU1teWAgru3Pi0AEk=;
        b=rc4H630sOMslhZyhrnQXXSwuK62lLsHmqPlPyi87VeM+Tgudg9CI+QnzthG5dpOK4V
         NoEWow45c4tHUSuIPyU9WLIOnUCHrd7CitR382Z2MALc2L1JzqptxfVkmzIf9fv8F542
         lc1g8DNrtZOA/ccccIIhaQrWDTcweo0V2vdqIUprplaUVar8zFn4P6/Z7CcbmdfOsee5
         iE6fFAhkTY5Grg5w2MP6puw+OhQ3VFlOA3oaNeB21tIqdvs4JTgpUQ6U30Ji05+xLFBS
         FXl35341R29Kd+BEaS2MrVK3BpzLVHEz7mL24behVg62gv1M24IWAcQBABYbxIkvnq0R
         lOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9Umfx2q/XCP+aMYDWDv4Y72De0TU1teWAgru3Pi0AEk=;
        b=fRwcqbXo11DloxvqhqkNa/g79f8YIUpz8U9bjwhv4c3ky18R7Ew5QzADVRpih/QWHs
         MQLUfMo8v928IoGwkhLB3eeC4P8iSvfxqSKtl1/CF3mlWWv/QVhPx2bSUyNbUX3dQrFp
         qAjYX9YBNkbvvSd2j5gLVeP/azbdz0m9XyxaQbH0HgVf8x9pgYlV/GBz1CTWrnD3XjCQ
         2kUb3//wUkBqUtioDYpXTWw2/tRwqnG4aLE7sgJjhXZyrQDEbOkgg3qJBP0fnuNwPFzy
         3UQ6nIxUADUTFc7sVKk9gQqMFi7iT5EDweMGKKa8+0OE37L8Sc/1xKjE/1XeFS6fhInj
         hqsQ==
X-Gm-Message-State: AOPr4FUeSiLk/8jEoVz7YfxEJceH0pgwHXXQpd9/HIkpCHelnu6dDEzl6C5VdVLaD3E/8A==
X-Received: by 10.140.178.15 with SMTP id y15mr36024718qhy.44.1462221689688;
        Mon, 02 May 2016 13:41:29 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id k184sm9844703qke.45.2016.05.02.13.41.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 13:41:28 -0700 (PDT)
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293286>

On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> Hi David,
> 
> here are my patches for a protocol v2.
> 
> ("Negotiate capabilities before doing anything else", or as code:
> 
>         static void upload_pack_version_2(void)
>         {
>                 send_capabilities_version_2();
>                 receive_capabilities_version_2();
> 
>                 /* The rest of the protocol stays the same,
> capabilities advertising
>                    is disabled though. */
>                 advertise_capabilities = 0;
>                 upload_pack();
>         }
> )

Overall, except for the comments I made, these patches seem sensible. 

Would it be possible to add some docs on the new protocol when you re
-roll?  (I know these are just the initial patches, but it really helps
me to see an explanation along with the code).
