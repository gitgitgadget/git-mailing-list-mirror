From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Mon, 24 Feb 2014 18:55:13 +0100
Message-ID: <420A7160-BA6E-4FB4-9323-55DA8EAA1E9F@quendi.de>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com> <BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de> <xmqqsird6137.fsf@gitster.dls.corp.google.com> <FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de> <xmqqr46w4a24.fsf@gitster.dls.corp.google.com> <8732A8C8-145E-47F5-BD9A-ECD6E9DE07EF@quendi.de> <xmqqtxbobg98.fsf@gitster.dls.corp.google.com> <xmqqppmcbfuo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:55:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzkT-0002vw-7G
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbaBXRzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:55:17 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:39674 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753136AbaBXRzP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 12:55:15 -0500
Received: from ip-95-223-14-124.unitymediagroup.de ([95.223.14.124] helo=[192.168.178.35]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WHzkH-00051D-IP; Mon, 24 Feb 2014 18:55:13 +0100
X-Mailer: iPhone Mail (11B651)
In-Reply-To: <xmqqppmcbfuo.fsf@gitster.dls.corp.google.com>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1393264515;78ff1ad8;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242620>



> Am 24.02.2014 um 18:06 schrieb Junio C Hamano <gitster@pobox.com>:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> But I think I was worried too much into the future---I agree that
>> the code can stay as you proposed until such a remote-helper needs
>> more support, because "overwrite with zero" is necessary but is
>> probably not sufficient---it also may need to be able to tell us
>> what the final resulting commit of the push is, for example.
> 
> So, here is what I'll queue (with forged s-o-b).

Thank you, I hereby declare the forged s-o-b as legit ;-)

> 
> Thanks.
> 
> -- >8 --
> From: Max Horn <max@quendi.de>
> Date: Fri, 21 Feb 2014 10:55:59 +0100
> Subject: [PATCH] transport-helper.c: do not overwrite forced bit
> 
> If the the transport helper says it was a forced update, then it is
> a forced update.  It is however possible that an update is forced
> without the transport-helper knowing about it, namely because some
> higher up code had objections to the update and needed forcing in
> order to let it through to the transport helper.  In other words, it
> does not necessarily mean the update was *not* forced, when the
> helper did not say "forced update".
> 
> Signed-off-by: Max Horn <max@quendi.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> transport-helper.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index abe4c3c..705dce7 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -727,7 +727,7 @@ static int push_update_ref_status(struct strbuf *buf,
>    }
> 
>    (*ref)->status = status;
> -    (*ref)->forced_update = forced;
> +    (*ref)->forced_update |= forced;
>    (*ref)->remote_status = msg;
>    return !(status == REF_STATUS_OK);
> }
> -- 
> 1.9.0-291-g027825b
> 
> 
