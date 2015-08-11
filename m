From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] usage: try harder to format very long error messages
Date: Tue, 11 Aug 2015 09:34:31 -0700
Message-ID: <xmqqtws5ss14.fsf@gitster.dls.corp.google.com>
References: <20150811161752.GA14829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 18:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPCVb-0004Ee-7w
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 18:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370AbbHKQef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 12:34:35 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36367 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbbHKQee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 12:34:34 -0400
Received: by pdco4 with SMTP id o4so85440650pdc.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=s8FDVL5xQyf4rjwGm2YOUDA+ICmEw21PEAfVRBOLkhc=;
        b=Ubqj2MoITL2dhblbf5DoYNR9Xe44Ad4VWZ3ucss0ZyKN/CgGrR10CwGSJqMApYgSnT
         GcMyRYnMoRUunksDEHzFhaD6Ioi5GXiXTJyqDXLNcsYaFYIId/F/69Q4mMy3Rau9yIFK
         baEgNgWHJx0rDGIL0Xsv7Wj80iypgXyamdJrUBJZ/twOMI+D39kqQXgipzLVhWPFsh3/
         dZ4R5gotF4JangpwAVnrlmgQaun+TZAMzo64Knc7un/RzbMjxRQ1UevYFfvA7uB+9ANi
         RYOSNkC3sbc6XnxoTytX6N/dA8/hp2biEjot6j0kN35GnD0WRd7XR0hS91GAgou0mSIk
         EIRA==
X-Received: by 10.70.20.196 with SMTP id p4mr58293503pde.58.1439310873951;
        Tue, 11 Aug 2015 09:34:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id dr4sm3240659pbc.61.2015.08.11.09.34.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 09:34:33 -0700 (PDT)
In-Reply-To: <20150811161752.GA14829@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 11 Aug 2015 12:17:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275698>

Jeff King <peff@peff.net> writes:

> We use a fixed-size buffer of 4096 bytes to format die() and
> error() messages. We explicitly avoided using a strbuf or
> other fanciness here, because we want to make sure that we
> report the message even in the face of malloc() failure
> (after all, we might even be dying due to a malloc call).

Yes, that was the rationale behind the "we use a fixed-buffer and
try not to allocate in this codepath", I think.

> As for vwritef, it exists solely to work over write(), _and_ it doesn't
> get the "one-shot" thing right (which is probably OK, as we use it only
> when exec fails). But we could probably teach run-command to fdopen(),
> and get rid of it entirely (in favor of teaching vreportf to take a
> FILE* handle instead of assuming stderr).

Sounds like a plan ;-)

The patch looks very sensible.
