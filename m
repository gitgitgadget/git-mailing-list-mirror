From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 5/6] git-reflog: add create and exists functions
Date: Thu, 25 Jun 2015 16:31:34 -0400
Organization: Twitter
Message-ID: <1435264294.7900.3.camel@twopensource.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	 <1435173388-8346-6-git-send-email-dturner@twopensource.com>
	 <xmqqioabzoz2.fsf@gitster.dls.corp.google.com>
	 <xmqq381fzlei.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 22:31:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8DoF-0002ay-Er
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbbFYUbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:31:40 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36397 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbbFYUbi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:31:38 -0400
Received: by igbiq7 with SMTP id iq7so266453igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=cJ2/vKg6PSxRUGA9ny5phPqm+v2/KbU1aGxPJzoXTb0=;
        b=IPos2/MkoIzRO6zKdX7o1FmO2TIUQ9yP54W5WOkP/jybyhHW0uTs1tO9uILVuBdgQ7
         /3jZwIwbLoYmxvrTdVD6Xv+Fwsl1IKOhyxOW6HtAitgSIjsRuNd8QPLI25QHeMUthG94
         VujBnoi5YzhRpY+xXJkv4L0jW/Lx1y6z+VuSJJXnqeS506jT0FAB2ZiESdiig8kkeuME
         hziE3cn7OdF9mFcGCXyX1mhJ+Nxsww09KpeHiW752tDXDMNuuarLoyHLgHVZI9YT4Rff
         eaDsS0VDnFiiaAmhVvfVssbvVd6W4SfVDim5DcNkJ/6ZE+OrWUA9ZzdITmblro3E93Vk
         I6jA==
X-Gm-Message-State: ALoCoQm286pgHm0JK0Gh8amYo1gNpCqdXW6NFZBB6YVQfB9tbZjlevg1sS2RieMrp1EKKQgD61mg
X-Received: by 10.50.79.202 with SMTP id l10mr6681609igx.7.1435264297660;
        Thu, 25 Jun 2015 13:31:37 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id d96sm13497333ioj.37.2015.06.25.13.31.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 13:31:36 -0700 (PDT)
In-Reply-To: <xmqq381fzlei.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272724>

On Thu, 2015-06-25 at 11:35 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Now, going back to 4/6, I think create_reflog() function as an
> > external API has a few problems.
> >
> >  * Its name does not tell us what should happen when a reflog
> >    already exists for the refname the caller asked to "create"
> >    reflog for.  I understand that this only makes sure it exists and
> >    does not destroy existing one.  Its old name, log_ref_setup(),
> >    did not have this problem, but now it does.
> > ...
> >  * Add a thin-wrapper for callers that do not care about the path to
> >    the log file, e.g.
> >
> > 	int vivify_reflog(const char *refname, struct strbuf *err)
> > 	{
> 
> As usual, I am aware that I am not good at naming things (but I can
> tell when somebody uses a bad name), and "vivify" may be a horrible
> name for that.  A reroll with a better name is very much welcomed.
> 
> Perhaps prepare-reflog?  I dunno.

I'll try safe_create_reflog, by analogy to safe_create_leading_dirs.
