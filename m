From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 08/11] transport: connect_setup appends protocol version number
Date: Tue, 26 May 2015 15:21:37 -0700
Message-ID: <xmqq1ti3j7ym.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 00:21:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxNEF-00032c-K5
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbbEZWVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:21:39 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36405 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbEZWVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:21:38 -0400
Received: by iepj10 with SMTP id j10so304921iep.3
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fuIdc9MozKayFMGNUOFTWcF/BwX5vsl+xYGPWJqC/50=;
        b=DGIb0jxy6XfYr/g0XuFcd5eKTKvtrGyAP9IIB4lFv3z2FXw2OfwVhxuT2jksCcFTTA
         hdT71G9DLUowkFbew+AJPcX+o1sdf2YkVYhMHQBI134NVcy7mm5XJU9atJ1MO4UOU+0W
         0jouuwJMLMcIsbiAjSwLVkREyft9Da6oZZ2OWZGzHZaYbYPeoUXO04lt18OOlds9+uJH
         nNpWqPkCkuZlm4fpIsLV6uHZCr4kGEyLQQq1PNKI5Q+eGeoHda9s4uYFFsCYb4uiY7Bp
         T3YSJQvn/Q5bBzf6yOJz8tIievahe/37IvNYahaGVtX7W7qobw/uy5vljgUlzlErwidA
         iJNQ==
X-Received: by 10.107.15.149 with SMTP id 21mr33791598iop.44.1432678898301;
        Tue, 26 May 2015 15:21:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id f82sm12029369iod.44.2015.05.26.15.21.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:21:37 -0700 (PDT)
In-Reply-To: <1432677675-5118-9-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 May 2015 15:01:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270002>

Stefan Beller <sbeller@google.com> writes:

> +	if (transport->smart_options
> +	    && transport->smart_options->transport_version) {
> +		buf = xmalloc(strlen(remote_program) + 12);
> +		sprintf(buf, "%s-%d", remote_program,
> +			transport->smart_options->transport_version);
> +		remote_program = buf;
> +	}

Bikeshedding: so the versioning scheme is that the current one is
zero, and the next one is two?  I would have expected that there
would be something like

	if (...->version < 2) {
        	... append "-%d" ...
	}

involved.
