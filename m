From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/2] diff: don't read index when --no-index is given
Date: Tue, 10 Dec 2013 10:18:40 -0800
Message-ID: <20131210181840.GC2311@google.com>
References: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
 <1386697935-18635-1-git-send-email-t.gummerer@gmail.com>
 <1386697935-18635-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 19:18:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqRtT-0002UA-2I
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 19:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab3LJSSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 13:18:46 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:59347 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab3LJSSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 13:18:45 -0500
Received: by mail-yh0-f52.google.com with SMTP id i72so4142187yha.39
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 10:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=caJCVIG29ITgQP1p3puIa7gQWWcn+lyTdTfXzbipZkE=;
        b=jXO7996qbEpjfnaxDV/7x9JnsNulJ6N6BB9/QSxoe63Euzbf1TlXBv8PJDJ6o+yNH8
         ifsNK/+I0PAmMxG+ozsrHXcltinHQoHigEi7rvw5IiphPLfNhOFBPjTLzRK1cHjIeu5r
         C7wDTskiA/xAJ8MKYHzdWgXjBJfwLNInwzggHIMsH/4LoGL1nAzbxXOcXU07V4z2QSwe
         zBCfkIAKMj7qaEP1SFRvUKLE/GtNYjoMkNxJxVIzXHoQR1mQh3vL6U9Ji8iQGtAevw6h
         aQhHoIoSe0m5HuoSNMs0WSwovj2A4kSnl/2yigcmwebh3vTe93Fq8nqH7Erh5cj8phtH
         QmDQ==
X-Received: by 10.236.197.70 with SMTP id s46mr1224723yhn.154.1386699524873;
        Tue, 10 Dec 2013 10:18:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h23sm14595yhc.0.2013.12.10.10.18.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 10:18:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386697935-18635-2-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239144>

Thomas Gummerer wrote:

> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -295,7 +295,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			break;
>  	}
>  
> -	prefix = setup_git_directory_gently(&nongit);
> +	if (!no_index)
> +		prefix = setup_git_directory_gently(&nongit);

What is the value of nongit in the no_index case?
