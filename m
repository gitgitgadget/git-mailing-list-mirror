From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [JGIT PATCH 1/2] Add support for boolean config values "yes",
 "no"
Date: Thu, 07 May 2009 12:56:15 -0500
Message-ID: <eOxTQ_L3wmawK8rFbXMLnksiI7lh8eiyptpquFGaI28e3RO7dN9GMw@cipher.nrlssc.navy.mil>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 07 19:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M27pl-0000C7-CZ
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbZEGR41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbZEGR41
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:56:27 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55328 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZEGR40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 13:56:26 -0400
Received: by mail.nrlssc.navy.mil id n47HuGjd013262; Thu, 7 May 2009 12:56:18 -0500
In-Reply-To: <1241708714-20326-1-git-send-email-spearce@spearce.org>
X-OriginalArrivalTime: 07 May 2009 17:56:16.0379 (UTC) FILETIME=[1E3934B0:01C9CF3D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118499>

Shawn O. Pearce wrote:
> In 8f8c6fafd92f (shipped in 1.6.3) Linus taught C Git how to read
> boolean configuration values set to "yes" as true and "no" as false.
> Add support for these values, and some test cases.

Linus added support for "on" and "off" in that commit as it appears
your commit is also doing. :)

I was about to point out that you are not ignoring case for "on", but
using equalsIgnoreCase() appears to be unnecessary since above that
you are already doing n = n.toLowerCase().

-brandon


> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> index cb287ee..e3a303f 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> @@ -254,10 +254,19 @@ public boolean getBoolean(final String section, String subsection,
>  			return defaultValue;
>  
>  		n = n.toLowerCase();
> -		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n) || "true".equalsIgnoreCase(n) || "1".equals(n)) {
> +		if (MAGIC_EMPTY_VALUE.equals(n)
> +				|| "yes".equalsIgnoreCase(n)
> +				|| "true".equalsIgnoreCase(n)
> +				|| "1".equals(n)
> +				|| "on".equals(n)) {
>  			return true;
> -		} else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n) || "0".equalsIgnoreCase(n)) {
> +
> +		} else if ("no".equalsIgnoreCase(n)
> +				|| "false".equalsIgnoreCase(n)
> +				|| "0".equalsIgnoreCase(n)
> +				|| "off".equalsIgnoreCase(n)) {
>  			return false;
> +
>  		} else {
>  			throw new IllegalArgumentException("Invalid boolean value: "
>  					+ section + "." + name + "=" + n);
