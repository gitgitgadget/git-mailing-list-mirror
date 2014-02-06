From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] check-attr: move to the top of working tree when in
 non-bare repository
Date: Thu, 6 Feb 2014 12:17:43 -0800
Message-ID: <20140206201743.GW30398@google.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
 <1391712033-9443-1-git-send-email-gitster@pobox.com>
 <1391712033-9443-2-git-send-email-gitster@pobox.com>
 <20140206195310.GV30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:17:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVOQ-0000KM-J5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbaBFURr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:17:47 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64518 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbaBFURq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:17:46 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so2220942pbc.36
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zXioNWuvCkkJ/XICMoDZdXjQtik99XAHu7w+q+XBXeo=;
        b=zHisTaZx19vSiffDVgWDDTEKnIHXP38qPtNm44v6ttMUzxY3WT/gEOhWJ0sShjuDIl
         v0/qWDoCSMPtfwyTFEVGrPyIaGYhApd3M87CuNGF4r8/txEk7btiMggyYsuM6H/JV2SP
         MTbuYcf800Jkgo0Rjn+ZY4ptPR8YkvVMktDNLTLIJnkF56bYmg9MmZD0iSjYkbf/pciw
         7dj4VnRPJs6A4F7TKyWPx99ZgtgL/5R94Y7JMytseINv5Iqo20bK4ykf6ikEfj6G5nFa
         mz62Y0ZllKZJa/i8KP/kauVXINAOciztDAD8Pae95eG1Tm8EDghVIigc3NrfuMdmOKyq
         4ExA==
X-Received: by 10.68.201.226 with SMTP id kd2mr14425621pbc.157.1391717866113;
        Thu, 06 Feb 2014 12:17:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id i10sm14563914pat.11.2014.02.06.12.17.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 12:17:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140206195310.GV30398@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241725>

Hi again,

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> +	if (!is_bare_repository())
>> +		setup_work_tree();
>
> Hm.  Shouldn't check-attr error out when run without a worktree and
> without --cached?
> 
> That would mean something like
> 
> diff --git i/builtin/check-attr.c w/builtin/check-attr.c
> index e9af7b2..c34b6ee 100644
> --- i/builtin/check-attr.c
> +++ w/builtin/check-attr.c
> @@ -107,6 +107,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, check_attr_options,
>  			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
>  
> +	if (!cached_attrs)
> +		setup_work_tree();

Someone asked in a private reply how this interacts with t0003.

t0003 tries check-attr in a bare repository.  The question is, is that
a desirable feature, and are people relying on it?  If people are
relying on it, perhaps the intuitive behavior would be to make
check-attr use an only-look-at-HEAD mode by default when running in a
bare repo.

How do I use the only-look-at-HEAD mode from a non-bare repo?  If I
want attributes with respect to some other commit instead of HEAD, is
there a syntax for that?  The command doesn't seem to have been well
thought out.

Hope that helps,
Jonathan
