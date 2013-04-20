From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/6] cat-file: do not die on --textconv without textconv
 filters
Date: Sat, 20 Apr 2013 16:27:48 +0200
Message-ID: <5172A5E4.7020902@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net> <06f2d51bf0479f3231b707d88d8d04fcd306c973.1366389739.git.git@drmicha.warpmail.net> <20130420041737.GC24970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 16:55:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZCX-0001sz-HS
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 16:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab3DTOzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 10:55:35 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60867 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751481Ab3DTOze (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 10:55:34 -0400
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Apr 2013 10:55:34 EDT
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 62CD32093C;
	Sat, 20 Apr 2013 10:44:28 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Sat, 20 Apr 2013 10:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=47T2vi0y98Wmk+boivtaMp
	kKz1I=; b=q5MMbGTeM0YdZbEZ5ztAo7zJpp6RMcIwxqoG+gr5hHRIDPvmYyk8Wp
	FoX6Qi78lcgI5TBJbx0U/G7c9KDjs+LirQbnYFHrI3eVyAS0Qs6OTffI2W6zyyas
	ShiqgKSGtH8pNjDRHWenSQLFnp8HObqbAdZwazYfF9qgRX1Fb8Ab8=
X-Sasl-enc: kV22jfvDvBZawxZNli409maezr/qqmxoPdvcK/znxRV0 1366469068
Received: from localhost.localdomain (unknown [88.70.147.219])
	by mail.messagingengine.com (Postfix) with ESMTPA id AFA71C80005;
	Sat, 20 Apr 2013 10:44:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <20130420041737.GC24970@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221856>

Jeff King venit, vidit, dixit 20.04.2013 06:17:
> On Fri, Apr 19, 2013 at 06:44:46PM +0200, Michael J Gruber wrote:
> 
>> -			die("git cat-file --textconv: unable to run textconv on %s",
>> -			    obj_name);
>> -		break;
>> +		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
>> +			break;
>> +
>> +		/* otherwise expect a blob */
>> +		exp_type = "blob";
>>  
>>  	case 0:
>>  		if (type_from_string(exp_type) == OBJ_BLOB) {
> 
> I'm not sure this is right. What happens with:
> 
>   git cat-file --textconv HEAD:Documentation
> 
> We have failed to textconv, but should we be expecting a blob?

Very true, thanks. I'll reorder so that the --textconv case continues
(without break) into the -p case. I think it makes sense to consider
"--textconv" to be "at least as pretty as -p".

Michael
