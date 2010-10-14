From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: fix In-Reply-To for second and
 subsequent patches
Date: Thu, 14 Oct 2010 13:22:50 -0500
Message-ID: <20101014182250.GA18341@burratino>
References: <1287049138-13940-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Thu Oct 14 20:26:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6SVU-00048K-QV
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 20:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab0JNS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 14:26:19 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49042 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0JNS0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 14:26:18 -0400
Received: by qyk9 with SMTP id 9so1102641qyk.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UeTNJScJ8tA0L3KUUuWudpiBFTP9RHBht76XvGEYxq4=;
        b=lNd+QVqg6jtJmRe3oMximylnfxR1WdLGeKSJZL05cEnsdpEtAg5Gx251DclipkiSpi
         VwGU6W3mEY12QKEigi5CY3AbyJ1Z0S3zr5Szt2XUBKXVtRJUljZRQ2OZBj8l30YiF5IW
         d5OgZGpWKxPbF2ih+pfdOYBOhKZ1/ViDLve+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pmQMRP1XkVw7izjyyBMDzouVoP7EjnWwyjQ4Ec3j3WzE0g2LmOmECn8fF6d+A6pqSb
         410GEZJ+hp2D2D1735BD0BlUtRMGMDCQhwsU7AdouLZcd6qJ4g4znZko0oqnc1x322nO
         /HNklYh59FK8RN/nNnbAMMkM2lt9cTsqLZJks=
Received: by 10.224.20.7 with SMTP id d7mr7009989qab.386.1287080777940;
        Thu, 14 Oct 2010 11:26:17 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm7430995qcb.27.2010.10.14.11.26.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 11:26:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287049138-13940-1-git-send-email-ospite@studenti.unina.it>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159063>

(+cc: some send-email people)

Hi,

Antonio Ospite wrote:

> Make second and subsequent patches appear as replies to the first patch,
> even when an initial In-Reply-To is supplied
[...]
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Thanks.

>   - When $initial_reply_to is asked to the user, it is asked as the
>     "Message-ID to be used as In-Reply-To for the _first_ email", this
>     makes me think that the second and subsequent patches are not using
>     it

This kind of justification belongs in the commit message, no?
That way, we can save future readers the trouble of figuring out
the rationale all over again when considering future changes to this
code.

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1313,7 +1313,7 @@ foreach my $t (@files) {
>  
>  	# set up for the next message
>  	if ($thread && $message_was_sent &&
> -		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0)) {
> +		($message_num == 1 || chain_reply_to() || !defined $reply_to || length($reply_to) == 0)) {
>  		$reply_to = $message_id;

Would it be possible to break this long line?

If you're feeling particularly adventurous, it would be nice to add a
test for the changed functionality to t/t9001-send-email.sh, so we
don't break it with other changes in the future.

I haven't looked too deeply or even tried running applying the patch,
but generally it looks good to me.

Ciao,
Jonathan
