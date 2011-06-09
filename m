From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 15/19] transport-helper: update ref status after push
 with export
Date: Thu, 9 Jun 2011 04:10:45 -0500
Message-ID: <20110609091045.GE4885@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-16-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 11:11:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUbGg-00048d-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 11:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab1FIJK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 05:10:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36934 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab1FIJKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 05:10:53 -0400
Received: by iyb14 with SMTP id 14so1138389iyb.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LxFO0563i9A3DjCPR7loBMzt6bFO+kQdkuFfIAttj3I=;
        b=FzVgMtAYJWj8P8OlFKGrk+f68X0cqoLZzgHGggr3ubF/FlJb8GhG/1mcgygv2GTf9Z
         4ZzGD5l58mxQLV8bLRyi3W9hvlMmXtR3wxYftVM8dfK+PqjTIWeJKJWi1ykXAjvEDJpU
         tUz8V3LC3XG6q9yeWBj2uw/s5spg0FSwMTThE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S9e6tek6gUIVxWMcvvUa3QDHgQdmNDREr/hNgClINncXIo7vVeFsQUIFzCgeET4Gn6
         FWDRDRdnSoouxUxk2PCGwibYXOUVUiclh9V29QqprwTAoPOLpaqeCWFbPjTMQgBRZZwN
         ML8CV3k/Aj52wofoqQRF55ozF/+UKUfLdoDYo=
Received: by 10.42.147.133 with SMTP id n5mr795537icv.203.1307610651420;
        Thu, 09 Jun 2011 02:10:51 -0700 (PDT)
Received: from elie ([69.209.61.87])
        by mx.google.com with ESMTPS id e1sm1169081icv.20.2011.06.09.02.10.48
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 02:10:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307558930-16074-16-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175510>

Sverre Rabbelier wrote:

>  Obviously the testgit helper shouldn't just print 'ok' for master,
>  but it demonstrates the idea.
[... and more interesting commentary ...]

The above probably belongs in the commit message.

[...]
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -760,6 +760,7 @@ static int push_refs_with_export(struct transport *transport,
>  	data->no_disconnect_req = 1;
>  	if (finish_command(&exporter))
>  		die("Error while running fast-export");
> +	push_update_refs_status(data, remote_refs);

Now the conversation looks like:

	git>          	done [from fast-export]
	remote helper>	ok refs/heads/master
	remote helper>	[blank line]

and after patch 17:

	git>         	done
	remote helper>	ok refs/heads/master
	remote helper>
	git>

which is to say, this implements the "approach C" mentioned in reply
to patch 10 that ensures that the remote helper gets the blank line
telling it disconnect is imminent.  Good to see.
