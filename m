From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] sequencer: Expose code that handles files in
 .git/sequencer
Date: Wed, 10 Aug 2011 10:21:26 -0500
Message-ID: <20110810152126.GE31315@elie.gateway.2wire.net>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 17:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrAbN-0001vp-KC
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 17:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab1HJPVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 11:21:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53748 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab1HJPVb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 11:21:31 -0400
Received: by yxj19 with SMTP id 19so722483yxj.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=orfwQfmcUtB97vWrSgSx9RLfIDICzLu6v6ooDDu3dZY=;
        b=hrci0bx56jCrMmEVwKG9xm3J/yT1YLpk0r8FUqPfJHd1IcZvQeBARfQeBNKpuCm1y3
         OmgIAqpX3X+bEpWIIJnOsPjOUvzXxgvDcUGw+7ka1UgtOhDGHbyZmGYgoUHJWjngmiLJ
         +HLY7q9c0S7iTVNz8sTQwBbDXpnUr6SqMErDg=
Received: by 10.91.68.5 with SMTP id v5mr7405477agk.1.1312989690460;
        Wed, 10 Aug 2011 08:21:30 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id c18sm862887anp.33.2011.08.10.08.21.29
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 08:21:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312970151-18906-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179069>

Hi,

Ramkumar Ramachandra wrote:

> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -38,6 +38,17 @@ struct replay_insn_list {
>  	struct replay_insn_list *next;
>  };
>  
> +/* Unrelated commit_message helper */
> +struct commit_message {
> +	char *parent_label;
> +	const char *label;
> +	const char *subject;
> +	char *reencoded_message;
> +	const char *message;
> +};
> +
> +int get_commit_message(struct commit *commit, struct commit_message *out);
> +
>  /*
>   * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
>   * any errors.  Intended to be used by 'git reset'.
> @@ -48,4 +59,14 @@ struct replay_insn_list {
>   */
>  void remove_sequencer_state(int aggressive);
>  
> +struct replay_insn_list **replay_insn_list_append(enum replay_action action,
> +						struct commit *operand,
> +						struct replay_insn_list **next);
> +void sequencer_read_todo(struct replay_insn_list **todo_list);
> +void sequencer_read_opts(struct replay_opts **opts_ptr);
> +int sequencer_create_dir(void);
> +void sequencer_save_head(const char *head);
> +void sequencer_save_todo(struct replay_insn_list *todo_list);
> +void sequencer_save_opts(struct replay_opts *opts);

This looks wrong.  What is the expected calling sequence?  Would it
be possible to expose fewer functions by moving more to sequencer.c?
