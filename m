From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 14:55:22 -0400
Organization: Twitter
Message-ID: <1431456922.16652.26.camel@ubuntu>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	 <1431384645-17276-4-git-send-email-dturner@twopensource.com>
	 <xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	 <1431455779.16652.20.camel@ubuntu>
	 <xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:55:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsFL0-0007lm-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 20:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933607AbbELSz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 14:55:26 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35919 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933316AbbELSzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 14:55:25 -0400
Received: by qcbgy10 with SMTP id gy10so9847045qcb.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 11:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=oIJRZbaAGB3WS5/to/QtpKPW3l3gSr4vOqPTSGYPDA4=;
        b=lqjF7HhJqSpLrFRxcUKnr4wo/GQw8hezTIzFOkGs7qdlzfrIa+IZ0fRIJu43XYzDxj
         y9viS7+aakD1hdrHVprfU25JWiYJhHv6llsxjH9usDoxgrsSIVsi8n+grUACxcx0DKLX
         gLWXkUny9MNwiW/aqEdLaEZNYdlHKOHqPTK6c53/edoShR5pZXC5gb5SgGrIYDG+tdFS
         yja+toLMpDR0hLK3oOcxPy5UZrlorsJUsBp6SnCJXFrEKzjWNumypEw7oUNArR5fdFYE
         qjeGSuNrpSkHKQBZhtTFZl4AgLdbryg8Wnro7YPIgvrE2t1SD62n6cmqo7E3AlNxemA/
         Fs8g==
X-Gm-Message-State: ALoCoQlmAUxj5yjDVMErMZZYbT118AWKE19lkYZVyS79uNS/4A909WDchaincDfbh2x4E0bPqfsK
X-Received: by 10.55.53.8 with SMTP id c8mr35754315qka.63.1431456925041;
        Tue, 12 May 2015 11:55:25 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id e18sm13827743qhc.22.2015.05.12.11.55.23
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 11:55:24 -0700 (PDT)
In-Reply-To: <xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268871>

On Tue, 2015-05-12 at 11:43 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> >> We need to also say something about the "missing" vs "loop" case, if
> >> we choose to leave that part broken.  I'd rather see it fixed, but
> >> that is not a very strong preference.
> >
> > Will add an example.
> 
> I do not think we need an example.  By "also say", I meant in
> addition to "This and that does not currently work", we also need to
> say that loops do not work well.  In other words, it is enough to
> just mention that it is a current limitation (or a bug, whichever we
> choose to call) that loops are reported as missing.

The version of the patch that we are commenting on contained the text: 
> +     --batch-check.  In the event of a symlink loop (or more than
> +     40 symlinks in a symlink resolution chain), the file will be
> +     treated as missing.  If a symlink points outside the tree-ish

Is that sufficient?  

Actually, we could simply have a separate output for broken links.
Instead of [original path] SP missing, [original path] SP loop.

I would probably implement this with a special error return code
(SYMLINK_LOOP=-2 instead of the usual -1). 

Does that seem reasonable to you?
