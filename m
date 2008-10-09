From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [JGIT PATCH 2/5] Fix UnpackedObjectLoader.getBytes to return a copy
Date: Thu, 9 Oct 2008 23:46:48 +0200
Message-ID: <2c6b72b30810091446y22cb2e00te7a25676ee21ddac@mail.gmail.com>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org>
	 <1222824690-7632-2-git-send-email-spearce@spearce.org>
	 <1222824690-7632-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 23:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3MX-00063w-Uj
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbYJIVqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbYJIVqv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:46:51 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:32380 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbYJIVqu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:46:50 -0400
Received: by yx-out-2324.google.com with SMTP id 8so69380yxm.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EAx8kalIjRr2VEZ5RLU/QmOH78AzhRoRQuzo/i+Y+H4=;
        b=OiOpITCpSIyDAQfQz+udQzk9qEbTrRd0rvP343JliYSoeK9LL6l/rwpove9LfSXdjv
         2D1TuR37MKFu55wj1kvurBT9zr1nkhNy6sD4B/XTtWiEHxi6GYuIqvRsqZF6qeyg56d4
         0f/FJnd5UmJ7zYEVVCpZSSUItVWKPMm1WaHCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=j+zUFKz6xW3+5n42QjmUJvqX03/H6YKlGdoYMV14ZAj9XAauRPLeai5slnG0td2gCd
         c5RgGps6C1+es5k6Uw74GNLbkk4qivJc66IHXHIKeX5OR1s+JPrMiQSGwhOYbWL14RYl
         7LDW5SDrxztH8AvD/jnjyW1etHmJKv15eSi70=
Received: by 10.142.212.19 with SMTP id k19mr363205wfg.13.1223588808546;
        Thu, 09 Oct 2008 14:46:48 -0700 (PDT)
Received: by 10.142.11.13 with HTTP; Thu, 9 Oct 2008 14:46:48 -0700 (PDT)
In-Reply-To: <1222824690-7632-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97893>

On Wed, Oct 1, 2008 at 03:31, Shawn O. Pearce <spearce@spearce.org> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
> index 5282491..87e861f 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
> @@ -105,7 +105,12 @@ protected void setId(final ObjectId id) {
>         * @throws IOException
>         *             the object cannot be read.
>         */
> -       public abstract byte[] getBytes() throws IOException;
> +       public final byte[] getBytes() throws IOException {
> +               final byte[] data = getCachedBytes();
> +               final byte[] copy = new byte[data.length];
> +               System.arraycopy(data, 0, copy, 0, data.length);
> +               return data;
> +       }

If I understand correctly, shouldn't this return the copy variable?

-- 
Jonas Fonseca
