From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 13/21] refs: resolve symbolic refs first
Date: Wed, 13 Jan 2016 11:33:29 -0500
Organization: Twitter
Message-ID: <1452702809.16226.1.camel@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	 <1452561740-8668-14-git-send-email-dturner@twopensource.com>
	 <xmqqmvsaqqk5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:33:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOMZ-0007sZ-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbcAMQdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:33:33 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34632 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbcAMQdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:33:31 -0500
Received: by mail-qg0-f41.google.com with SMTP id 6so379785022qgy.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=QyTQkqXMbWwUzCD6ONaYBm3sTqbmwY63LU3yz0e4Efs=;
        b=Xe3iuACg+DDzZaWXy+80IzWnw373xlD1DJ29sFOgpZDiRRUZ1bepEnJalraoEzLJjU
         AdyD2TM2Ktf5I2tUx/P/69d4r8hOjVG4PoE+ZK/stD23dqRN6rohaGwYAupG9uKYR7f0
         ObBbJE44/owFuqUEQ6ubnLBMsmZ8mhSYqTH3QZhhFtVnmPp30Jny4tRoKxQivTOpnpRg
         JDbWo+HhZXSC9Zl+qeNzUhCSiiK4yIx/Xj8/3Oat5vUAGDrMBA9/yILZWOQdaeWMqgwf
         UUAVkjhmw0EVRHZIe6Q4rose8vWv4/XmR925+Av+UtOe3PYrLdUikP+1ODDpAVCgkbXN
         l86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=QyTQkqXMbWwUzCD6ONaYBm3sTqbmwY63LU3yz0e4Efs=;
        b=MgjW0LveaCWzsBpiTCFBxtPTIojfEIMENFQ29X302GwIYA5gd42zGaSExkXmzSBJKf
         sSPYdc4kccNVEDR5Y1tMA/0KVesjzBEwZ3ZhYvDGUIcswUa6cYXHpSlte/Q01t3KTEos
         Nkrr+s36ihCaXZS9Ta1+wj3QXPkj+4K1ZcHNvZpX4nqvo04FZdPzBwH/qIZk5a8V7k5g
         h5gjJACh6e9VyUPyiL1ZR4aMz9urbLqs75zhpi1iv2qfiehBH2lRwxW/MIKXoKCjQVmD
         vxo0h2/2Ri+Oh1rO1fC7MaGHwhilAlnEh4FG9Vxk9DRt4K9dgwIH/LmAr64riJ7F7gqy
         GjZw==
X-Gm-Message-State: ALoCoQkhb5QD4iiWHIFhlk9OuZsbSJsLlBkACiJLnq7WE1YTTy2I7o9M8pMLSNRTckcmintq7fl+TdLCyXS5Eq8fBSaxHcbhjg==
X-Received: by 10.140.173.132 with SMTP id t126mr189371376qht.96.1452702811229;
        Wed, 13 Jan 2016 08:33:31 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 63sm761626qgy.45.2016.01.13.08.33.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jan 2016 08:33:30 -0800 (PST)
In-Reply-To: <xmqqmvsaqqk5.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283926>

On Tue, 2016-01-12 at 16:19 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > +static int dereference_symrefs(struct ref_transaction
> > *transaction,
> > +			       struct strbuf *err)
> > +{
> > +	int i;
> > +	int nr = transaction->nr;
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		struct ref_update *update = transaction
> > ->updates[i];
> > +		const char *resolved;
> > +		unsigned char sha1[20];
> > +		int resolve_flags = 0;
> > +		int mustexist = (update->old_sha1 &&
> > +				 !is_null_sha1(update->old_sha1));
> > +		int deleting = (update->flags & REF_HAVE_NEW) &&
> > +			is_null_sha1(update->new_sha1);
> > +		struct ref_update *new_update;
> 
> This variable is never used (at least at the end of the series after
> applying up to 21/21).

Fixed, thanks.
