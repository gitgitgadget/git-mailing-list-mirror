From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v2] Speed up bash completion loading
Date: Mon, 16 Nov 2009 00:28:50 -0800
Message-ID: <4B010D42.4090902@gmail.com>
References: <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com> <20091111220832.GA31620@progeny.tock> <4AFCFF50.5080401@gmail.com> <20091113070652.GA3907@progeny.tock> <4AFD06CD.7090003@gmail.com> <20091113085028.GA4804@progeny.tock> <20091113090343.GA5355@progeny.tock> <4AFDC4F3.1050607@gmail.com> <20091114110141.GB1829@progeny.tock> <7vd43krwd0.fsf@alter.siamese.dyndns.org> <20091115102912.GA4100@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 09:29:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9wxK-0001oB-AB
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 09:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbZKPI2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 03:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZKPI2u
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 03:28:50 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58684 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZKPI2t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 03:28:49 -0500
Received: by yxe17 with SMTP id 17so4517925yxe.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 00:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=iWlKhAf/SOB3fnihV3P8knhZgNa5voCNma6c30GdrT0=;
        b=rR7mY2I/2waZuUzezN+fNUZFQME9HZjsc1dH0Ml8od+7ZAu54s6bcN9oW2CXyeLjWy
         huz4j+8a0LB1gORwrrXuzc7JtUeJjErBb7hoAX4TRMI2LjBUZmUzniB5byhbgwZrVQiN
         +/bjE//3SDAVnyhbwBBe7loMDCgxGLqAUoyuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=r9uY3x6hLr9kL9T1Gg6SsIj3n+ar/yfdX/pRJXPAxBV5CkR5L/usffLlwZ7tPwxHtB
         G12Oylr/TUqD7Kbd9cvf0P4Ws2vun6Xq0XOYI6ZAgqQia/j4INRsfHxYgSG4F7Q/pzbN
         ortDx/oXsQXNTnfYmnG1cA3f0va6vPRJoUc8U=
Received: by 10.101.6.13 with SMTP id j13mr49649ani.80.1258360135169;
        Mon, 16 Nov 2009 00:28:55 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 6sm1475162yxg.66.2009.11.16.00.28.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 00:28:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <20091115102912.GA4100@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132992>

Jonathan Nieder wrote:
>
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>>  __git_compute_merge_strategies ()
>>>  {
>>> -	: ${__git_merge_strategies=$(__git_list_merge_strategies)}
>>> +	__git_merge_strategies=$(__git_list_merge_strategies)
>> Wouldn't
>>
>> 	: ${__gms:=$(command)}
>>
>> run command only until it gives a non-empty string?
>
> Yes. :)

Why not do this for all of the lists and not just the merge strategies?
