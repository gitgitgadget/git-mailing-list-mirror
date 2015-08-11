From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 03/13] ref-filter: introduce ref_formatting_state
Date: Tue, 11 Aug 2015 11:13:38 -0700
Message-ID: <xmqqd1ytsnfx.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:13:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPE3V-00009j-7G
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbHKSNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:13:41 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35618 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbHKSNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:13:40 -0400
Received: by pacgr6 with SMTP id gr6so55838852pac.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tT1vSBdfxLeHTrKNFYQCSCqTGJOjxcNXin6Bpv6vW14=;
        b=RXXpE4RfiFKKxxfx+Xa62nGQlcKRhStFGjsZOAMe+kuDJG6HhdpA4soyEdCkuHkGnu
         028/zaydfEawUq2e/7vcP7P6houPEKI8Jt9s/pLJGonilEnJF/KijDM3kmxt8ER43Un4
         qh1EDOl4JcNKmmJxy0SUfyoo1ODWPHbzhbfo1MYrBFOe99jGQWieSjyKf3pvYe9lRCEQ
         FK5nC1KvJCB9fkOjWTMxxkGBCgRs7Tk1vuJYtlMzjsuMl3gbhAiI9SIZHKT8ROGsZ/Qd
         5CIsHjR+mBuAgZpENXOJggE9pizFR921Kx/1sA02H8W61D6YcU8HWr2WfX4CWtgnklPc
         20VQ==
X-Received: by 10.67.5.231 with SMTP id cp7mr59296490pad.36.1439316820119;
        Tue, 11 Aug 2015 11:13:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id xs13sm3504952pac.3.2015.08.11.11.13.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 11:13:39 -0700 (PDT)
In-Reply-To: <1439129506-9989-4-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 9 Aug 2015 19:41:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275705>

Karthik Nayak <karthik.188@gmail.com> writes:

>  		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> -		format_quote_value(atomv, quote_style, &output);
> +		set_formatting_state(atomv, &state);
> +		format_quote_value(atomv, &state);
> +		perform_state_formatting(&state, &final_buf);
>  	}
>  	if (*cp) {
>  		sp = cp + strlen(cp);
> -		append_non_atom(cp, sp, &output);
> +		append_non_atom(cp, sp, &state);
> +		perform_state_formatting(&state, &final_buf);
>  	}

With the two helpers being very sketchy at this stage, it is very
hard to judge if they make sense.  At the conceptual level, I can
see that set-formatting-state is to allow an atom to affect the
state before the value of the atom is emitted into the buffer.
I cannot tell what perform-state-formatting is meant to do from
these call sites.
