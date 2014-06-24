From: David Turner <dturner@twopensource.com>
Subject: Re: Git-status / preload_index() performance
Date: Tue, 24 Jun 2014 16:12:18 -0700
Organization: Twitter
Message-ID: <1403651538.22828.4.camel@stross>
References: <53AA0129.1080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:12:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzZt5-0003hG-CM
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 01:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbaFXXMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 19:12:24 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44512 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbaFXXMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 19:12:22 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so1023697qcy.29
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 16:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=jQviV3QhkC66LEWR9lnb+c8cTLmb2rm+xQsH+YczRmU=;
        b=HICE+McX0RXj+Awo03HUQiVEV2+SrlaC4H9/qYX4ykZU/jbxG1/Fq5EPA8l1czEuK3
         gPK43EFYc1WV4vGMRGJQtDxW3sS1bpyzXTHnPgkCIK2EJnJnshVZ7Gd7/ArH4VrdYCX5
         EibS5QsN2OTIydyufmXC29N4XBUmwZ9Ik4QUCDYCaU/nWUWHAL5xyIPbNf3L3k8mLMc9
         /qEbtMI/RT3f/V6DAkF4EmKLaHUtgFnUkPWyMnwSHTcptd9cQbS9x10uC4dcQLiJWlNR
         X8rv0/jwjZapO+Y5mY8hCGyJ9GIJzpFddJxIB7MFj8Ny/fdrU9Yx1tupFhkkaXywSYsC
         JyOQ==
X-Gm-Message-State: ALoCoQmsuMvhQJ17Mz8ZDU0WUtbjfF49qAd4Fx0SYUnjRaTcEod55svi/mbeq9h8T5VfuN0l4VZA
X-Received: by 10.224.24.200 with SMTP id w8mr6496956qab.35.1403651541790;
        Tue, 24 Jun 2014 16:12:21 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id b9sm2742669qae.4.2014.06.24.16.12.19
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 16:12:20 -0700 (PDT)
In-Reply-To: <53AA0129.1080109@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252425>

On Wed, 2014-06-25 at 00:52 +0200, Karsten Blees wrote:
> Even more time is spent unpacking the HEAD tree, even with hot cache (repacking with depth 10 reduces this to ~250ms, on SSD its just 7ms). Perhaps caching the HEAD tree in an index extension could help here?

This is approximately what the cache-tree extension does.  However, it's
a bit broken.  I've been working on a fix, but slowly because my other
work has taken me longer than expected.  You can see the effect of the
cache-tree extension by doing git reset --hard HEAD; this temporarily
restores that extension.
