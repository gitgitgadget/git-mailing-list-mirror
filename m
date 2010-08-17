From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG?: git-apply sometimes says "corrupt patch" when adding
 single lines
Date: Tue, 17 Aug 2010 18:43:14 -0500
Message-ID: <20100817234314.GK2221@burratino>
References: <AANLkTineHiG9vCpbJzJ2x9CFjZ7LQeExs7cN5YhoZhft@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 01:45:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVq1-0004Vb-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab0HQXo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:44:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46874 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab0HQXoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:44:55 -0400
Received: by vws3 with SMTP id 3so5146645vws.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aW7AZEKvzvN09uwQaz+AiZZoxK9cSr9brTr/ttkzAD4=;
        b=vpXmUgQFMbysPDb1JotesQk1AlCPmXGi24xqxYbndi8gM62S0qD7CibMMvqUjdo5zk
         rLkAxjcyApC7hF+hSEhFsx57ZqVypz6q82BPRgdBfSQDW0J6dQFjUcpG/YaW+AbfN2JP
         rGF8nItIOYP9iAiWaCWJebKrKcjArqmD6/X4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jbO6Z3ccrj0LcsroxWXKoniEkT77K+4TrJm2tiw7pW/J/tXzANnvcwp7w0S3WnHNC0
         c9ZTtztgFg3MEwCQAeDoOZ2MoaJf5FNFealeAvmrqKX8fO4BzqPjVCA5AWbZLR777ggR
         DvR5qDRIM9OFTDkUHWdy1sxrpymIzTEO9yrsM=
Received: by 10.220.125.88 with SMTP id x24mr4448003vcr.205.1282088695178;
        Tue, 17 Aug 2010 16:44:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id s20sm2452856vcr.4.2010.08.17.16.44.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:44:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTineHiG9vCpbJzJ2x9CFjZ7LQeExs7cN5YhoZhft@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153792>

Tor Arvid Lund wrote:

> I don't really know the git-gui code or the git C code well, but it
> seems that I got around the error with this small patch:
> 
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 12ef9ea..124791f 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1335,6 +1335,8 @@ static int parse_fragment(char *line, unsigned long size,
>  		 * l10n of "\ No newline..." is at least that long.
>  		 */
>  		case '\\':
> +			if (newlines == oldlines == 1)
[...]

Heh.  This code is a roundabout way to say "if (newlines == oldlines)",
rather than "if (newlines == 1 && oldlines == 1)" that might have been
intended.

Unfortunately I do not have any more insight than that.  If you can
give an example reproducing this with git apply from the command
line, that would be very helpful.

Thanks,
Jonathan
