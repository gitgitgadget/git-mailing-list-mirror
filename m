From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/12] initial_ref_transaction_commit(): function for initial ref creation
Date: Mon, 15 Jun 2015 11:53:04 -0700
Message-ID: <xmqqioao952n.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:53:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ZVR-0002id-1c
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbbFOSxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:53:08 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33479 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754514AbbFOSxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:53:06 -0400
Received: by igbos3 with SMTP id os3so26345703igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yRx+yeGORUcM+W2g0ZE5SgldTpLln680FEKamOH1kSo=;
        b=DABzm2BUmgAw3uavJmAe7ycZWRoC64K0e74f5Qzve1dy5QA2fCPpcYnG0BooPkFfHR
         RHeboew2IGZp/iJuZT9N+JQkpgJntIYuXOBsSTTGjpdD0KjEbBrmUfSEv+h4tzvQHI5D
         cS+HZWjlwQbqX4gk4LLmfkY9aElAoCGkLYc1+MUX2ucmiDs66CFi6E3vKzoXIEkDIsx0
         Fh1aaRXiRHIpHR4i3uCzT6OhfpvqjzNPdwnm67cUAzTvk2xXMupCTcKuRKe+4KALkBv4
         TD5PnU8K3XDCOlUHeY3qnLaOFdPEDXWY2KJiVUnaCCtferkfTCdQl3iGkEM/ngxxxYZK
         u0+Q==
X-Received: by 10.50.43.196 with SMTP id y4mr22665003igl.14.1434394386435;
        Mon, 15 Jun 2015 11:53:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id u35sm9406056iou.7.2015.06.15.11.53.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:53:05 -0700 (PDT)
In-Reply-To: <19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 13 Jun 2015 16:42:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271707>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +	struct ref_transaction *t;
> +	struct strbuf err = STRBUF_INIT;
> +
> +	t = ref_transaction_begin(&err);
> +	if (!t)
> +		die(err.buf);

Yikes, and sorry for sending three messages without consolidating
against the same patch, but

	die("%s", err.buf);

because

extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));

in its declaration causes -Werror=format-security to barf.

Likewise for a few other instances of the same construct all in 
the same file.
