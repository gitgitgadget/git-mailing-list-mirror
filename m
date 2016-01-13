From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 14/21] refs: always handle non-normal refs in files
 backend
Date: Wed, 13 Jan 2016 11:34:05 -0500
Organization: Twitter
Message-ID: <1452702845.16226.2.camel@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	 <1452561740-8668-15-git-send-email-dturner@twopensource.com>
	 <xmqqfuy2qqk1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:34:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJONB-0008JP-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbcAMQeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:34:09 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34345 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbcAMQeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:34:07 -0500
Received: by mail-qk0-f180.google.com with SMTP id t64so37242519qke.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=B1RcvZug8vDp5+AwG2k+ZGJOLo6DvqsD2LAL03qiwcE=;
        b=u3xPakrbs6wYG83tCOUuTVdZFJV/AVD+1DSytBwGgbxTdEI2f0s9BjwN5YPSQNuac8
         k59ehqHnQHkl3LOhKoqvjRkddaZSpsU5MGtTBoOwqNl8ZyBwFXrBiRS6Y/SSg2eENfH1
         WONrWDkF2UbDFZLUUuUybznaEdLpPAx/tQRW6dDxThHY7eWvuZUUc03hWifBa67iw6OJ
         GmmfmwRcDHYZDVXPQ9j7NWzgLKCV4BxWaTjwojEC7PXdVJoy5QWmATvken37kdISOC8P
         4r2V1dTD+/k3njhnZU3oXGjocOeJ+qS0pSUf80+kgb9+qCt9y0N4KbuNVOCu4WkWBhPb
         4DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=B1RcvZug8vDp5+AwG2k+ZGJOLo6DvqsD2LAL03qiwcE=;
        b=IWwSdjMJ04YAfdGYALkhffgYz/zaUrWyN5tBuCuZ0eJ2LnIKxG2bpiu4h7ZQkFqzPQ
         UbWYMBEFDGhNtLdaKTviNoGPzbcgcPDbf6wnkA67Rek2p1xUwRev1VT9AqZQyr76rlDs
         p2C/44zG61LIGEq4q+aiNaRhj+pPPwJnPDmwLwZ9dXYAmdNc14Lcs29qMzGZ3LurtSwV
         AZNmmmdb3dl6IJ5Wwv5TxJCfR2c2qg0G4Arl7/clV4UW2SZS4aUKHtcVT+RMjp1FFIJb
         /4P/jn7aZgGnR32mPTOW+/DvwjzU8rBLKVBh210SYfnCszP8aE7BE3sDLcD6kGvYjny+
         BarQ==
X-Gm-Message-State: ALoCoQkv14bxS1scM2MMVZfxD+8AUtW2U/TkYXdmNQP8UAmW4i1QiyfPNSIPuqytpZu9sWgRpb2HG8dVNjzZKehCws2S+XmgCA==
X-Received: by 10.55.195.67 with SMTP id a64mr40555950qkj.4.1452702846967;
        Wed, 13 Jan 2016 08:34:06 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id j23sm773691qge.23.2016.01.13.08.34.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jan 2016 08:34:06 -0800 (PST)
In-Reply-To: <xmqqfuy2qqk1.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283927>

On Tue, 2016-01-12 at 16:19 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> >  int ref_transaction_commit(struct ref_transaction *transaction,
> >  			   struct strbuf *err)
> >  {
> >  	int ret = -1;
> >  	struct string_list affected_refnames =
> > STRING_LIST_INIT_NODUP;
> > +	struct string_list files_affected_refnames =
> > STRING_LIST_INIT_NODUP;
> > +	struct string_list_item *item;
> 
> This variable is never used (at least at the end of the series after
> applying up to 21/21).

Fixed, thanks.
