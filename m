From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv10 01/10] receive-pack.c: shorten the execute_commands
 loop over all commands
Date: Mon, 5 Jan 2015 12:22:44 -0800
Message-ID: <20150105202244.GL29365@google.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
 <1420482355-24995-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	sunshine@sunshineco.com, mhagger@alum.mit.edu,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 21:23:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8EAv-0005HW-C4
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 21:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbbAEUWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 15:22:48 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:49455 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbbAEUWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 15:22:47 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so3080149igj.4
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m0EZ3jgvCHh13PYjxDXY+gwmz3LAo/UzvGni/1yq4aI=;
        b=FN61NljlvxyJiu2HaDJqbQcd7rbHWxPuSUoOcfZAp4EoH5sfLyezzh4+Wxv0J4+rTP
         76r77eIcN8BuALPSoIkp05fubsNcwaUBGzNitBGEpPOr6NL3JHapJYovlJnw+9fDAnTp
         Sp0DOerV2WzPReLrywEyI3/U0T5kYWzt9Z/Rkwdfl0/ne0XcolOUYP/982ysCN8PlJmI
         WuTHA37SB6B8CaIOV06hSa4yeQOKjQDzbRfq+JWX7rZqHCm9Qy3E3rqJaBMgJjU1D1pm
         RzTU8PyoEAQs5DGg1bJcvj9hGTx33Mu72wGZV8uc5AzYa9LNugMhZst7MLVvG5XeDEMi
         4ITA==
X-Received: by 10.50.142.105 with SMTP id rv9mr12626148igb.41.1420489366933;
        Mon, 05 Jan 2015 12:22:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:cbe:c7db:3064:452c])
        by mx.google.com with ESMTPSA id o72sm27061948ioo.14.2015.01.05.12.22.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 12:22:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420482355-24995-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262032>

Stefan Beller wrote:

> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
[...]
> @@ -1077,27 +1100,15 @@ static void execute_commands(struct command *commands,
[...]
> +	if (shallow_update)
> +		assure_connectivity_checked(commands, si);

Looking at this code alone, it seems like assure_connectivity_checked()
is going to ensure that connectivity was checked, so that I can assume
connectivity going forward.  But the opposite is true --- it is a
safety check that prints a warning and doesn't affect what I can
assume.

The factored-out function fails in what it is meant to do, which is to
save the reader of execute_commands from having to look at the
implementation of the parts they are not interested in.

Would something like warn_if_skipped_connectivity_check() make sense?

Jonathan
