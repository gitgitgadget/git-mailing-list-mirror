From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] Making reflog modifications part of the transactions
 API
Date: Mon, 8 Dec 2014 13:54:15 -0800
Message-ID: <20141208215415.GS16345@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
 <CAGZ79kb1yiSENO+uANdeOKtcSCZgZA3UXSdE2F5PBA49erh2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 22:54:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy6G7-00009n-1D
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 22:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbaLHVyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 16:54:19 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53318 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbaLHVyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 16:54:18 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so5207148iec.24
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vkp4SDQZBawTaLMop7fI1u5woJmuILtwt8BHDdwSULU=;
        b=YWClW0iAR8LbM/dNqLTrz6OXmTaJr3bBwoStQaeIQKK4W6wpOAFd5+DqG/YWfMoLLv
         jQBBdb37DTIdNzygtgnlftisr+g6ISBSFimiwPWxXWvfkR3QIFRMcOk2/JoHF0quraq6
         NbHxG7xy5YlfSp4rCuwfvoc+H3leKyUO7KWetjN25YOU/1DVK/UXcVYiZTBXixpiT8ih
         fGemW3VqNB/Jnw/vQW/wR4PCKVDvAIMLf6DiFHMUqJ12Vk5YCtejyAM0KC8T52Ymu1O1
         MgJNiKo3ITwuGQihtt4sW891i1N2PfGp8cTGN/RYmTckWBiPsDKR7JezPz5j+XANQd1y
         b8sQ==
X-Received: by 10.107.40.16 with SMTP id o16mr13507489ioo.26.1418075657888;
        Mon, 08 Dec 2014 13:54:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41c9:2fc6:1317:4ac])
        by mx.google.com with ESMTPSA id f143sm4629348iof.27.2014.12.08.13.54.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Dec 2014 13:54:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kb1yiSENO+uANdeOKtcSCZgZA3UXSdE2F5PBA49erh2Jw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261085>

Hi,

Stefan Beller wrote:

> How do we view an empty reflog, i.e. an empty file at logs/refs/heads/master?

That's a good question.  I'm a little concerned about what 'git reflog
expire --updateref' would do in this case.

It looks like the longstanding behavior is for 'git reflog expire' to
expire any entry that is old enough, even if that entry describes the
current value of the ref and the reflog becomes empty.  The empty
reflog file is kind of like having no reflog at all, except it means
git should log updates to that ref even if core.logallrefupdates is
false.

That suggests that two separate operations delete_reflog (for 'git
reflog delete') and truncate_reflog (for 'git reflog expire') would be
needed.

Thanks for catching it.
Jonathan
