From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and
 export it.
Date: Wed, 25 Feb 2015 13:22:06 -0500
Organization: Twitter
Message-ID: <1424888526.2968.3.camel@leckie>
References: <54EDACC9.5080204@gmail.com>
	 <1424862460-13514-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQgb9-0008Ul-OG
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 19:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbbBYSWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 13:22:11 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:56258 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbBYSWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 13:22:10 -0500
Received: by mail-qa0-f42.google.com with SMTP id w8so4071767qac.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 10:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=7fpT0j7E2jf1fNFFzv8iU125A/F0PrmvBmDCCfFzlxg=;
        b=SEyNe4EbZNbunaPdwDFUnWMbk2l/Sk5IYjNyexsbdJGhgKvQTxhCrSNuiaTmCKkxpq
         zILb4WVVw+KRjv713XUHIzoXJxL8p3IPoZuiRZEFICsEalCDRaDsHPmqEUGpOsVIwKN/
         i+ACknY+Ii+EodgxF/j9ChbLkMwF80sMYt+3N5/4TWv56mEJEj5c1AoEtPmMfSHLo2tp
         t6gnZB58Odb78jg4C/HN7Qj8acKAJPELiG8xdrsQFUgjlwdahl60B+F6KKYuwHnEJSt4
         vXYxS5hqeoYX/0MmkHbQb0fdNBcNaQKa2HfUfxRLV7GZOcCPnXMqvW3jElJmLE6rn+NP
         C/pA==
X-Gm-Message-State: ALoCoQkZrenEbtDwdlmWR5BlGs/NkpZ1VVUglR/CcGrL5CFhl7eF6txfV5dxwRnpx+9Jha4VhTaO
X-Received: by 10.140.150.149 with SMTP id 143mr10006777qhw.4.1424888529846;
        Wed, 25 Feb 2015 10:22:09 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id i48sm31941507qge.34.2015.02.25.10.22.08
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 10:22:09 -0800 (PST)
In-Reply-To: <1424862460-13514-1-git-send-email-karthik.188@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264398>

On Wed, 2015-02-25 at 16:37 +0530, Karthik Nayak wrote:
> +	unsigned long mapsize;
> ...
> +	map = map_sha1_file(sha1, &mapsize);

I know this is a pre-existing issue, but I'm not sure "unsigned long" is
the right type here.  Shouldn't it be a size_t?  

> +	if (!map)
> +		return -1;
> +	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> +		status = error("unable to unpack %s header",
> +			       sha1_to_hex(sha1));
> +
> +	for (i = 0; i < 32; i++) {

This number should probably be a constant.

> +		if (hdr[i] == ' ') {
> +			type[i] = '\0';
> +			break;
> +		}
> +		type[i] = hdr[i];
> +	}

type might end up without a trailing \0 here in the case where hdr has
no space in it.  Is this possible?
