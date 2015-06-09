From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/19] pull: error on no merge candidates
Date: Tue, 09 Jun 2015 16:56:33 -0700
Message-ID: <xmqqeglkwi4u.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-10-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:56:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2TNt-0006WH-7v
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbbFIX4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:56:37 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37152 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbFIX4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 19:56:35 -0400
Received: by igbsb11 with SMTP id sb11so22202684igb.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ArLYGsSZwFa0uCBrpoVndx58CJvTCJx+ZYGl03H+HLA=;
        b=F9YNu0t3Yt8ul4RisfuGJTNEDnH/FPZlZWFM1AB4cSXPfOeCBv7z7qrNo8a5JsxHFc
         J+kCBW2NMgASwtpsyWhJpS3N7rJuYf1jIzAPNmQScy8Wu+eDjGEtZDBEpxC+e0B62mhi
         LDuAdtNpeTipSMIsgg+tI4HW+V4jbs82UtdjkzjWqiIUKK4NyefH8FTY+61O2Ftkbs0h
         fQ9fkLWoYQvUYtwH8+zUO2YPNKbcvfn0RVb8EmXS9cjflueE9jEbn5NfKpPQux5nBcow
         JIakXw6+Uj2WUqaawHiPjqcksYZt39mC/mdSJAT+WRb/ly+spfQ/5a2xilWWyoUWTm65
         b8Fg==
X-Received: by 10.107.15.149 with SMTP id 21mr486340iop.44.1433894195283;
        Tue, 09 Jun 2015 16:56:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id av6sm2228927igc.17.2015.06.09.16.56.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 16:56:34 -0700 (PDT)
In-Reply-To: <1433314143-4478-10-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 3 Jun 2015 14:48:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271244>

Paul Tan <pyokagan@gmail.com> writes:

>  /**
> + * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
> + * into merge_heads.
> + */

Hmph, I vaguely recall doing that in C elsewhere already, even
though I do not remember where offhand...

> +static void get_merge_heads(struct sha1_array *merge_heads)
> +{
> +	const char *filename = git_path("FETCH_HEAD");
> +	FILE *fp;
> +	struct strbuf sb = STRBUF_INIT;
> +	unsigned char sha1[GIT_SHA1_RAWSZ];
> +
> +	if (!(fp = fopen(filename, "r")))
> +		die_errno(_("could not open '%s' for reading"), filename);
> +	while(strbuf_getline(&sb, fp, '\n') != EOF) {

Missing SP after "while"

> +		if (get_sha1_hex(sb.buf, sha1))
> +			continue;  /* invalid line: does not start with SHA1 */
> +		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge"))

Look for "\tnot-for-merge\t" instead?

The patch overall looks good.  Thanks.
