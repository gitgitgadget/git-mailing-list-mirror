From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] add warning for depth=0 in git clone.
Date: Tue, 08 Jan 2013 09:09:55 +0100
Message-ID: <50EBD453.9050101@googlemail.com>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 09:10:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsUGK-00006t-Hr
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 09:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab3AHIJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 03:09:59 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:51894 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3AHIJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 03:09:59 -0500
Received: by mail-bk0-f54.google.com with SMTP id je9so51389bkc.13
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=O3FsLh/4mDx2EfgTOecbN/pvv+i4mnFiO323ZvlqH3Y=;
        b=cYQtmfTgoZl6Wp6wwIABo9Y7DYN7g14ktiUUp/sIDlFFVDhVrwn4XW0yBJuM5NRYsY
         v3KLNXjeBxkiAquQ8apfejtAfMauCxcXiHI5mq2iXm3jH/D0JXcdxx+Va/6LqMY46BXH
         AfTCUXLmv3IN2I4QPPRT8jPmMp+wRILXAvK3HEI9mdI4DqUwH3EA/uDLoN5bkLW3Oe9C
         Da9wpK2qk3ewRt525EeOwimVtDWASWluKCVLMobyVQpHUStixiTTY8SuHUYvdIi0Nb9H
         id8DQ3+LcR+HdqX8k26DSXKJnUAJAAX3g9ew2GpKoySHmRUhBKRnkmaUSljZk2k29j2i
         50jQ==
X-Received: by 10.204.146.92 with SMTP id g28mr31067499bkv.127.1357632597918;
        Tue, 08 Jan 2013 00:09:57 -0800 (PST)
Received: from [192.168.1.3] (ip-109-91-111-92.unitymediagroup.de. [109.91.111.92])
        by mx.google.com with ESMTPS id e22sm44439049bke.14.2013.01.08.00.09.56
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 00:09:57 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212947>

Hi,

I am struggling a little with the development process,
is a sign-off strictly required for git as it is for kernel development?
If so here would be my sign-off:

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

This adds a warning and the previous patch adds the documentation.

However I agree to Junio, that the meaning should actually
depth=0 -> just the tip and no (0) other commits before.

depth=n -> the tip and n other commits before.


On 01/08/2013 09:07 AM, Stefan Beller wrote:
> ---
>  builtin/clone.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ec2f75b..5e91c1e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -818,6 +818,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	remote = remote_get(option_origin);
>  	transport = transport_get(remote, remote->url[0]);
>  
> +	if (option_depth && transport->smart_options->depth < 1)
> +		die(_("--depth less or equal 0 makes no sense; read manpage."));
> +
>  	if (!is_local) {
>  		if (!transport->get_refs_list || !transport->fetch)
>  			die(_("Don't know how to clone %s"), transport->url);
> 
