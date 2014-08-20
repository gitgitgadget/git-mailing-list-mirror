From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 16/18] receive-pack: GPG-validate push certificates
Date: Wed, 20 Aug 2014 12:56:37 -0400
Organization: Twitter
Message-ID: <1408553797.26173.3.camel@leckie>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	 <1408485987-3590-17-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 18:57:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK9CR-0000UY-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 18:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbaHTQ47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 12:56:59 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:57883 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbaHTQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 12:56:40 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so7277615qad.3
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 09:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ScgyBqXGEA3qmSN2PwUNH9F50Qytg26dz4mTf9WtfIU=;
        b=TZCiOQNBdaQOPylXthwVnqtDXN1LUQBRp85Fo2yrGGlc75hzG7xWDj+J0Uw3j0yzv9
         /SGHLDkVaxRN9obtkUSvJc/22kpXw1XIAYpUfpZZvT5H/fzGyrpNtDt41SaY4XkhRPRh
         ID8SSwmN83I/JA4+35V6pm1PqR146v5WSrRxtqqeVu6ntRkPIjqH9kzK27akWWjZJAWx
         hrsJFPGx/9W+24XMadRdE++lIFzr+6Frkrn5gn47pzoGRLdsGPQdboEl3Jw7oJmC+tXL
         n59HFbIGH+cWJqBxPDXyUgXiWWrcJaYwbUA0wiGozwDX/nffwarh+tuI8ZGMSGlG+BEe
         mAYw==
X-Gm-Message-State: ALoCoQmqpBecmXNTPX/cpjPGzsrWXtkkXE8MHnbduoOpwEuC5rEOB3VX/mlS0SKx5T9GLujJl15L
X-Received: by 10.140.39.233 with SMTP id v96mr74832271qgv.103.1408553799409;
        Wed, 20 Aug 2014 09:56:39 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id q9sm41496097qat.32.2014.08.20.09.56.38
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 09:56:38 -0700 (PDT)
In-Reply-To: <1408485987-3590-17-git-send-email-gitster@pobox.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255574>

On Tue, 2014-08-19 at 15:06 -0700, Junio C Hamano wrote:
> Reusing the GPG signature check helpers we already have, verify
> the signature in receive-pack and give the results to the hooks
> via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.
> 
> Policy decisions, such as accepting or rejecting a good signature by
> a key that is not fully trusted, is left to the hook and kept
> outside of the core.

If I understand correctly, the hook does not have enough information to
make this decision, because it is missing the date from the signature.
This might allow an old signed push to be replayed, moving the head of a
branch to an older state (say, one lacking the latest security updates).
I have not proven this, and it is entirely possible that I am wrong, but
I think it would be worth either documenting why this is not possible,
or fixing it if it is possible.
