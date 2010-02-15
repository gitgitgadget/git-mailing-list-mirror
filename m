From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv13 28/30] builtin-notes: Add -c/-C options for reusing
 notes
Date: Mon, 15 Feb 2010 02:34:47 -0800
Message-ID: <4B792347.8070208@gmail.com>
References: <1266096518-2104-1-git-send-email-johan@herland.net> <1266096518-2104-29-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 11:34:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgyI4-00059E-FU
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 11:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab0BOKev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 05:34:51 -0500
Received: from mail-qy0-f200.google.com ([209.85.221.200]:39757 "EHLO
	mail-qy0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab0BOKev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 05:34:51 -0500
Received: by qyk38 with SMTP id 38so123577qyk.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5iW4G1M2JgGy58ZYrz/ykDWgQfF+ezqtSQ+TXFthazc=;
        b=gFf8nNcSa5A1NW7GZx1yRCoE5+77RB5FugG+9PdlgC+K2ugL2Wt/I5ahBSHniPbLPH
         628QPfERBjmG6pVze7tWtfL53theGK0opgUpC3hThhCvi4SsNsP78+pAGm3mdkY/tGc2
         JLwHlb83z60xdY/vf4zjOTHducaCJJ0SSbC30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kMYhMPQXCR754tglvGQbghvqkUgJEx2JU++syDCnHmWewDQByY3mXjg7hewq+uXHEp
         gn4ba++OsvEVrD7K7RdtvlQgOATaT2Ba5qDsZkY890sT09c4bb0WgOU7+28JmNth+zth
         NseBT9vaW7qQWrtByvZZReg6PP1TgfNI7LwXM=
Received: by 10.224.27.157 with SMTP id i29mr2313398qac.147.1266230090119;
        Mon, 15 Feb 2010 02:34:50 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm209580iwn.8.2010.02.15.02.34.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 02:34:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <1266096518-2104-29-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140003>

On 02/13/2010 01:28 PM, Johan Herland wrote:
> @@ -199,6 +203,40 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
> +{
> +	struct msg_arg *msg = opt->value;
> +	char *buf;
> +	unsigned char object[20];
> +	enum object_type type;
> +	unsigned long len;
> +
> +	if (!arg)
> +		return -1;

This is impossible unless you're using the PARSE_OPT_OPTARG flag or
allowing negation (i.e. --no-reuse-mesage). You should probably make the
two callback options PARSE_OPT_NONEG and then drop this if statement.
Same applies to some of the other callbacks not introduced in this patch.

> +
> +	if (msg->buf.len)
> +		strbuf_addstr(&(msg->buf), "\n");
> +

Use strbuf_addch()? I saw this in a couple other patches too.
