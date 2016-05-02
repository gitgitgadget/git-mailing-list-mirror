From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 12/14] Add test for fetch-pack
Date: Mon, 02 May 2016 15:45:50 -0400
Organization: Twitter
Message-ID: <1462218350.4123.74.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-13-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:45:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJn3-0006bh-8T
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbcEBTpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 15:45:54 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33313 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654AbcEBTpx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:45:53 -0400
Received: by mail-qk0-f169.google.com with SMTP id n63so79523792qkf.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mqdr77cyvooPYPm0mjtzimwB20HCN4ugSkQfaJl5o3o=;
        b=pZfAJcmDgRU4AqdZZf5EMfZXEbOq2HoYmwqfWguo5aj+NQpgMN0Hvg7jqcR2xxWDLD
         ZpDT6wV1Bx7FRAYyyhck2Rdkk1+/qe5KkALLX2M+bnAtJ0Y8PUTL3jFU6O/1IcQrvU+q
         BD3DiQRnNTdzAHGQC8mVmmIMXMUhY6DHkuglTP9hBRTf1asWQyOBJowPnH+gc7WCE+KQ
         72eeeoiMoiGTtDhxzMNqHkwdb6yBlVdVWafp8J4jUIBkbneZJFIO6X8xHE5hWVmvorEo
         OOrY347iOE1Rx6tauhlQRE4c1uzric7Qx2nflv+7bwanJbv4QEaHbyS2anB76cExDAfj
         Rj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mqdr77cyvooPYPm0mjtzimwB20HCN4ugSkQfaJl5o3o=;
        b=UtyuYgh4sVzjrruLC5Ie7meIPtG3NOTpeo0bL3W72LEDytXEgxvpL7KV3TMK4A9iPI
         xT8X+xQ4ugymF/eKn5M4F3mNy7Eot/fHWC6H2owBwlGjLsKEUFTZKix8gkAE0drYVRQs
         rZDrcuKNhbtYuml9xgf9InyhuNkMWGPiBskNF3ittaCylSoE9ZEQvJBmdDWyCz8kHXFw
         PCKxy9ZvgmBOt2pFAoMklAfKhX10glFNPy4We0s+Trji7DPEVKLNL8JYmQwHJAKt/MUG
         JzALfXdI7NgN8nUw3KigEN5lZ3YoRoIwxkIDEhi/uc4LhYxoy5wK+UQxnWKb83oSRaiY
         dHmw==
X-Gm-Message-State: AOPr4FWuEHcvGoC4LjQARx8jY8839nsaNARx6oFO/Imrj/JtpgY0W3hgAMy3Tcunb2asZw==
X-Received: by 10.233.237.193 with SMTP id c184mr33992392qkg.88.1462218351996;
        Mon, 02 May 2016 12:45:51 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id a123sm9764443qkc.23.2016.05.02.12.45.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 12:45:51 -0700 (PDT)
In-Reply-To: <1461972887-22100-13-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293279>

On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> +test_expect_success 'fetch-pack with protocol version 2' '
> +	test_when_finished "rm -rf repo1" &&
> +	mkdir repo1 &&
> +	(
> +		cd repo1 &&
> +		git init &&
> +		test_commit 1 &&
> +		test_commit 2 &&
> +		test_commit 3 &&
> +		echo "$(git rev-parse master) refs/heads/master"
> >expected &&
> +		mkdir repo2 &&
> +		(
> +			cd repo2 &&
> +			git init &&
> +			git fetch-pack --transport-version=2 -
> -upload-pack=git-upload-pack-2 ../.git refs/heads/master >../actual
> +		) &&
> +		test_cmp expected actual
> +	)
> +'

This doesn't actually test that protocol v2 is in fact used (it just
tests that --transport-version=2 doesn't crash).  It would be nice to
actually test the version in-use.
