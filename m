From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] sequencer: remove CHERRY_PICK_HEAD with sequencer
 state
Date: Sat, 5 Nov 2011 19:15:38 -0500
Message-ID: <20111106001538.GD27272@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:15:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqOv-0003Ie-RB
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab1KFAPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 20:15:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48289 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab1KFAPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 20:15:48 -0400
Received: by ywf7 with SMTP id 7so3894119ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=z2gsxN9x5L9oPz/IEzMOb37iRN766f+sx36vg5a7gk0=;
        b=HmClmTsSzDpR6b8mRENTudH0Zzu2c7fSjHJ7OoGd1cgUmPzaQnaumXYPDa/vr5r3Vb
         7717hr7+OHtd9bs0Tbyqn59l2QjKnOxrQIIrC+be4Pd9sebGNSdx+ebRqCFkCDosLbWB
         arI0e7K5ztHXIZldPv70C38qDwh5PQ8CIM2K8=
Received: by 10.50.216.137 with SMTP id oq9mr26856372igc.40.1320538548023;
        Sat, 05 Nov 2011 17:15:48 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a6sm13913644igc.3.2011.11.05.17.15.46
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 17:15:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320510586-3940-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184884>

Ramkumar Ramachandra wrote:

> Make remove_sequencer_state() remove '.git/CHERRY_PICK_HEAD' when
> invoked aggressively, since we want to treat it as part of the
> sequencer state now.  While at it, make some minor improvements to the
> function.

What does it mean to invoke a function aggressively?  What is the
nature of these minor improvements (are they behavior changes or just
cleanups)?  (Remember, the reader hasn't seen the patch yet.)

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -25,17 +25,22 @@ static char *get_encoding(const char *message);
>  
>  void remove_sequencer_state(int aggressive)
>  {
> +	const char *seq_dir = git_path(SEQ_DIR);
> +	const char *seq_old_dir = git_path(SEQ_OLD_DIR);
> +	const char *cherry_pick_head = git_path("CHERRY_PICK_HEAD");

If there were just two more like this, the behavior would change
completely.  Scary.  Are these temporary variables needed?
