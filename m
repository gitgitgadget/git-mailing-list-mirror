From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 10:25:32 +0100
Message-ID: <4F211C0C.7060400@viscovery.net>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126074208.GD30474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 10:25:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqLaU-0002vw-NG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 10:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957Ab2AZJZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 04:25:38 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25526 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750842Ab2AZJZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 04:25:35 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RqLaH-0004t4-E0; Thu, 26 Jan 2012 10:25:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 30F2B1660F;
	Thu, 26 Jan 2012 10:25:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120126074208.GD30474@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189147>

Am 1/26/2012 8:42, schrieb Jeff King:
> +static int handle_ref_include(const char *ref, void *data)
> +{
> +	unsigned char sha1[20];
> +	char *buf;
> +	unsigned long size;
> +	enum object_type type;
> +	int ret;
> +
> +	if (get_sha1(ref, sha1))
> +		return 0;
> +	buf = read_sha1_file(sha1, &type, &size);
> +	if (!buf)
> +		return error("unable to read include ref '%s'", ref);
> +	if (type != OBJ_BLOB)
> +		return error("include ref '%s' is not a blob", ref);
> +
> +	ret = git_config_from_buffer(git_config_include, data, ref, buf, size);
> +	free(buf);
> +	return ret;
> +}

What happens if a ref cannot be resolved, for example due to repository
corruption? Does git just emit an error and then carries on, or does it
always die? Can I run at least git-fsck in such a case?

-- Hannes
