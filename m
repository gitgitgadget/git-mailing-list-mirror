From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 8/6] receive-pack: Send internal errors over side-band
 #2
Date: Wed, 10 Feb 2010 09:13:00 +0100
Message-ID: <4B726A8C.6010600@viscovery.net>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org> <1265767290-25863-2-git-send-email-spearce@spearce.org> <4B725CB1.1080908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 09:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf7hB-0006vO-6V
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 09:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab0BJING (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 03:13:06 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27708 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab0BJINF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 03:13:05 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nf7gz-0008JH-9L; Wed, 10 Feb 2010 09:13:01 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0655C1660F;
	Wed, 10 Feb 2010 09:13:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B725CB1.1080908@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139499>

Johannes Sixt schrieb:
> Or did you replace only selected error() and warning() calls by rp_error()
> and rp_warning()?

Actually, you want to send only selected messages to the pusher. For
example, these look like errors on the server side (right?) and should go
to the site administrator:

>  	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
> -		error("unpack should have generated %s, "
> -		      "but I can't find it!", sha1_to_hex(new_sha1));
> +		rp_error("unpack should have generated %s, "
> +			 "but I can't find it!", sha1_to_hex(new_sha1));
>  		return "bad pack";
>  	}

>  		if (!old_object || !new_object ||
>  		    old_object->type != OBJ_COMMIT ||
>  		    new_object->type != OBJ_COMMIT) {
> -			error("bad sha1 objects for %s", name);
> +			rp_error("bad sha1 objects for %s", name);
>  			return "bad ref";
>  		}
>  		old_commit = (struct commit *)old_object;

In particular, your patch does not send errors produced by unpack-objects
or index-pack to the pusher over the sideband, and this is the right thing
to do.

-- Hannes
