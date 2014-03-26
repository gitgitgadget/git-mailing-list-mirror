From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 19/27] refs: Add a concept of a reference transaction
Date: Wed, 26 Mar 2014 14:39:19 -0400
Message-ID: <53331ED7.9020004@kitware.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu> <1395683820-17304-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:46:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSsqL-0007UV-8j
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815AbaCZSqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 14:46:19 -0400
Received: from na6sys009bog019.obsmtp.com ([74.125.150.78]:35528 "HELO
	na6sys009bog019.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752780AbaCZSqR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 14:46:17 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]) (using TLSv1) by na6sys009bob019.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUzMgdYGvRElLA14xweXrx3dHzDaeSU40@postini.com; Wed, 26 Mar 2014 11:46:13 PDT
Received: by mail-ie0-f174.google.com with SMTP id rp18so2124997iec.33
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 11:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qCLICPVsQMAbYbVRpSMW+KaHpyen9uA8o6XMK9D0hv4=;
        b=G0bL5vqw9Ky34O8pQpxUVabjXddhhYJsMocxzecUWvoNYWss/vr8BAVF4DIeRBHA7h
         k3GWO0hSNEarWIb1hTzoZjceMwi0UuE4L73PcPZDy2n9/FSC4PIbvP5BYIrt+qkhaAQd
         7WZzOMDIO6Yyf8FgZ0J+rHZe/9FLbFyydodXB2RPh6grBrlCExZRilrhqWU0nbQctk4E
         6kckphwvhop3o+TPGwYZ+HwhvUjA8TPBBx1CneNVgTb758fWOxW0Ro7oI2O54Z2rEPlZ
         2mNe9AYFNxudl6Wknkn6xAnkpAeH6rZ2KRiUO71mQOkIjB3FXocXCEdCeZKZNpZbsW0L
         9pjw==
X-Received: by 10.43.18.135 with SMTP id qg7mr62871684icb.5.1395859112377;
        Wed, 26 Mar 2014 11:38:32 -0700 (PDT)
X-Gm-Message-State: ALoCoQmRlk8dTIFJlPXIeTOscqaVS6Q7863TWvRUb1OsfVS+Xnvhz3ZVxqpaAs4ScDUWKjXKnAzDYDj9rHvNKs01tPxx6yUn1LcpuqMKHazEkZHTtM9hvzJCUMDmVYI7/AYzAt8fqXqHE5nUDTiBitVAAuPDuFQdpQ==
X-Received: by 10.43.18.135 with SMTP id qg7mr62871664icb.5.1395859112257;
        Wed, 26 Mar 2014 11:38:32 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id qa11sm61678igc.12.2014.03.26.11.38.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 11:38:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1395683820-17304-20-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245207>

On 03/24/2014 01:56 PM, Michael Haggerty wrote:
> +void ref_transaction_update(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *new_sha1, unsigned char *old_sha1,
> +			    int flags, int have_old);
[snip]
> +void ref_transaction_create(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *new_sha1,
> +			    int flags);
[snip]
> +void ref_transaction_delete(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *old_sha1,
> +			    int flags, int have_old);

Perhaps we also need:

void ref_transaction_verify(struct ref_transaction *transaction,
			    const char *refname,
			    unsigned char *old_sha1,
			    int flags, int have_old);

as equivalent to the "verify" command in "update-ref --stdin"?

-Brad
