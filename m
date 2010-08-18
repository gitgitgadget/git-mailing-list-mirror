From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] merge-recursive: Workaround unused variable warning
Date: Wed, 18 Aug 2010 17:13:40 -0600
Message-ID: <AANLkTikVWd60Pe3-X2xj4mWhtiTf9VgydYJ7HKxsp+dd@mail.gmail.com>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
	<1281665352-10533-2-git-send-email-newren@gmail.com>
	<AANLkTikLXy4gPttmX=wzcDaFAfZO=OEk4PEDKh3sCSOF@mail.gmail.com>
	<20100818001032.GA7694@burratino>
	<7veidvagz8.fsf@alter.siamese.dyndns.org>
	<AANLkTik9mho7Pm5m=3dEbtMrH1r81Lc480i_z2_aHCxs@mail.gmail.com>
	<7vk4nn8soz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 01:13:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlrpM-0004C6-72
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab0HRXNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 19:13:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48712 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab0HRXNm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 19:13:42 -0400
Received: by fxm13 with SMTP id 13so665805fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cP/eqBFVZxnv2JFqI8kUvKomWDHPXBto5RP+TZY7+X0=;
        b=tGLIgxU77ZD8wYdFrItB5zGdR/oK/MuTjfRSVep9mrq3BUfPpt0GVh2u5+dmze6U5L
         ypSbQDtu1iqDXx9TkYk8NtXzO/WmB0X54At6sYJ//gnNjpQR317b4EPye/veH8BUTAbv
         GpbeHwaf5nlUxRzDBBnyHcUdcnDfAHhaP+i0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oLIiRDOza2BkxvDZbZ+h+7iQOR9ic6c9Jt/VEkVRYZk4HbIRw2MsrmmHHe7QKghL+N
         bK2JLEhmJwXH/EDrfRS1QA0zSsXFr70+CKFtWiWj2pj4hD6lm3/H6inc+YpIz3sbn5Uq
         hujUlFL995oT9MbLllQFp+gTlv6PWm06SNbfU=
Received: by 10.223.119.131 with SMTP id z3mr8488324faq.61.1282173220671; Wed,
 18 Aug 2010 16:13:40 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 18 Aug 2010 16:13:40 -0700 (PDT)
In-Reply-To: <7vk4nn8soz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153894>

On Wed, Aug 18, 2010 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I actually was hoping that my weatherbaloon patch will illustrate tha=
t a
> new special case these people may make to process_entry() to leave ot=
her
> cases unprocessed do _NOT_ have to be handled by process_df_entry().
>
> The "if" statement in process_df_entry() would check if the entry is
> something the function is ready to resolve, and otherwise punts. =C2=A0=
A new
> exception they add to process_entry() can introduce a separate phase =
(just
> like process_df_entry() is not done in parallel with other kinds of
> entries inside the process_entry() but as a separate post-processing
> phase) between the loop that calls process_df_entry() and the loop th=
at
> checks if there is a remaining entry. =C2=A0And it probably should, a=
s such a
> new exception may not have anything to do with "df", and adding such =
a
> logic to process_df_entry() would be wrong ;-).

That makes sense and sounds like a good idea to me.  I think we should
go with your patch, modulo possibly modifying the comment's wording.
