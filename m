From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] upload-pack: Fail if cloning empty namespace
Date: Fri, 12 Jun 2015 14:01:29 -0700
Message-ID: <xmqq616sd4k6.fsf@gitster.dls.corp.google.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:01:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3W53-0003au-CL
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbbFLVBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 17:01:32 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35831 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbFLVBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:01:32 -0400
Received: by iesa3 with SMTP id a3so31520070ies.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=1ozKtDDkx6AAIi9Kx/yAmN/MdnpvW4vwkhRX0QcWcrc=;
        b=HsIQsO/HUoC/vatGcK2Q2DP8FslBP5giFtAoRNGztvi7Cs9rCea8Xk26LV/9PVj7+R
         gPOpxI5JvlYx2eWxRRGcXHhMlEEW3GJoG1J4ibB6HyUo+w7j+/xRUBpUEwrbL0FLRqMx
         aKCw+iLwb2j6YvNgVa69svu3ENhB7ZAPGro0nOQfnRpxcxu3OL4/mi0G3x0IeNodffnn
         bGSyKMFTkY74ajh7U8hUc4FvQpe2OcciFZ8ssGZRwlbqErpvDijBZeuckw7WudFgEYb4
         2TMwKt0ypmTsASL8oes6rfupV3H7eBjm4kDx8NGM7ok1gqfe+9weDjZVM3nXPXH/o5il
         hDgQ==
X-Received: by 10.50.141.164 with SMTP id rp4mr7028613igb.2.1434142891616;
        Fri, 12 Jun 2015 14:01:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id u35sm3218917iou.7.2015.06.12.14.01.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 14:01:31 -0700 (PDT)
In-Reply-To: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
	("Johannes =?utf-8?Q?L=C3=B6thberg=22's?= message of "Fri, 12 Jun 2015
 22:15:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271522>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> +	if (get_git_namespace() && !symref.items) {
> +		die("git upload-pack: tried to clone from empty namespace");
> +	}

Is this sufficient?

get_git_namespace() returns environment.c::namespace, which is set
up in setup_git_env() by calling expand_namespace() and strlen()
is run on that value, so I would presume the function will *ALWAYS*
return true.  Even when not namespaced, you would get an empty
string "" whose address is not NULL, no?
