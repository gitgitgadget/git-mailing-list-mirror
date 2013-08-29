From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 0/7] Multiple simultaneously locked ref updates
Date: Thu, 29 Aug 2013 14:23:53 -0400
Message-ID: <521F91B9.5030801@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <201308290932.18199.mfick@codeaurora.org> <521F6CF0.6040905@kitware.com> <xmqq7gf479jm.fsf@gitster.dls.corp.google.com> <521F8033.6070302@kitware.com> <xmqqd2ow5q1h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6up-0008Ve-Iu
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab3H2SZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:25:51 -0400
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:50567 "HELO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756490Ab3H2SZu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:25:50 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]) (using TLSv1) by na3sys009aob122.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+SJaWSl9SOSFYhiO9lzX8rRgmcU1TW@postini.com; Thu, 29 Aug 2013 11:25:50 PDT
Received: by mail-oa0-f49.google.com with SMTP id i7so1079468oag.8
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zcjIJ7oWq4Xo0kzIJjbTI4q+CAdlqtZPLtqoCILP8QM=;
        b=Y+waY6xOhxbNADvARIqSRRl/2Cm7iOstHRNV0wMf5ec6xa60s9folZ3aP12tNbsBRw
         7X2iVml8iIalIzvJRwqDskDiVwAD/ICknRRNJ5d1tZcgcxF4pbl5f2NX4fI5/NRY2LQo
         OMNiknxfxrCLGgndKxp6hgBWJkJJM2YXu3pm88RndGJBPuQiSP51LHPoyp+NdN+XTxsM
         2tw+C8API2xcUGeqHbkmB9gjH5NGyFqMFTaD/EDAJiq8GV9TPH4D4RD7M9m58Cwz7RVd
         TqdeBZNIAQXpzKHmTIAM1x/q+wN5RY3tVSFoQk+cpFp+4LhEeZXbBvZ1rTKzhaGGT4fX
         21Wg==
X-Gm-Message-State: ALoCoQng1pcIgSrI7RwCoBrsFUQY0mren7obWgSvPkGr5F5b9ATywGzPvs01t/rbN02lQtss8MNSQAef2Bcj/NpSxPY4Tskrl6Uc0uNRdsyFRatH9nXO3juoEjN6HQ/GYLerlYSkfiAj+d76WtR3B3QCZ7KiFuFV/A==
X-Received: by 10.60.50.168 with SMTP id d8mr1540347oeo.77.1377800731957;
        Thu, 29 Aug 2013 11:25:31 -0700 (PDT)
X-Received: by 10.60.50.168 with SMTP id d8mr1540340oeo.77.1377800731862;
        Thu, 29 Aug 2013 11:25:31 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id r3sm33786036oep.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:25:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqd2ow5q1h.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233324>

On 08/29/2013 02:07 PM, Junio C Hamano wrote:
> I didn't mean to force the caller of new "update-ref --stdin"; the
> new code you wrote for it is what feeds the input to update_refs()
> function, and that is one place you can make sure you do not lock
> yourself out.
> 
> Besides, if you get two updates to the same ref from --stdin, you
> would need to verify these are identical (i.e. updating to the same
> new object name from the same old object name; otherwise the requests
> are conflicting and do not make sense), so the code to collect the
> requests from stdin needs to match potential duplicates anyway.
> 
> One clean way to do so may be to put an update request (old and new
> sha1) in a structure, and use a string_list to hold list of refs,
> with the util field pointing at the update request data.
> 
>> - this process already has the lock because it was asked to
>>   update the same file multiple times simultaneously, or
> 
> The second case is like left hand not knowing what right hand is
> doing, no?  It should not happen if we code it right.

Yes.  All of the above is what I originally intended when asking
the question in the cover letter.  Using string_list and its util
field may be useful.  However, see also my response at
$gmane/233260 about how it may fold into sorting.

Thanks for the reviews!
-Brad
