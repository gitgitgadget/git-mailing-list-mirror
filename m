From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] bisect: add the terms old/new
Date: Wed, 10 Jun 2015 09:08:17 -0700
Message-ID: <xmqqsi9zmtqm.fsf@gitster.dls.corp.google.com>
References: <1839018688.331427.1433920317370.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq7frcast5.fsf@anie.imag.fr>
	<xmqqwpzbmvr3.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0-R1UqSDbEeTKq_gX+uFw2egZetgziqaUiRqdivHvhPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2iYI-0006GH-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966648AbbFJQIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:08:25 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33334 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964973AbbFJQIV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:08:21 -0400
Received: by iebgx4 with SMTP id gx4so37602711ieb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ut1vc1FGenIgjkmDQusc1PhiS5eHfhXZhJGbm4HjZoI=;
        b=iLEp4/vQPxkBkhTgLXlzODgX3EqkHWwqXCasTZUSAzia93rec/WiFrYiV8tuw2HRPA
         JcqB3FEdcY2dk0nrcKiRhQZMJguEjysgqIAXA3ErlRuOI575r+6jXO9AWIpZDmmUCGXT
         qFMsnUdv2XdjncOjNPl+uwdlsSEug2DZGxUMu7bIUqudYX7OCa2iUgfT8D3BlbBqNXtS
         g8xAziCHTKK3onVHb9VTH/ECAnYF+9SAsPKLyij3FUU+o9ik2SRPkESPuu0uoez8/Cq8
         u+EbW1tZHEJRAXY2EoD7/0scWNLnQMH0YI/ZV54pgq4LA8y/Iuej8PKxRQ0CKAGhnaEs
         2t9g==
X-Received: by 10.107.157.205 with SMTP id g196mr5365889ioe.57.1433952500161;
        Wed, 10 Jun 2015 09:08:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id j20sm3523421igt.5.2015.06.10.09.08.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 09:08:19 -0700 (PDT)
In-Reply-To: <CAP8UFD0-R1UqSDbEeTKq_gX+uFw2egZetgziqaUiRqdivHvhPA@mail.gmail.com>
	(Christian Couder's message of "Wed, 10 Jun 2015 17:47:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271314>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Jun 10, 2015 at 5:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>
>>> Moving from "one hardcoded pair of terms" to "two hardcoded pairs of
>>> terms" is a nice feature, but hardly a step in the right direction wrt
>>> maintainability.
>>
>> Nicely put.  From that point of view, the variable names and the
>> underlying machinery in general should call these two "new" vs
>> "old".  I.e. name_new=bad name_old=good would be the default, not
>> name_bad=bad name_good=good.
>
> I don't think this would improve maintainability, at least not for me.
> The doc currently uses "good/bad" everywhere.

You are conflating the internal implementation and the end-user
facing interface, I think.

The topic under discussion is about updating the internal
implementation more generic and make it capable of handling both the
traditional and the default 'find transition from good to bad' and
any other kinds that can be expressed by 'find transition from $old
to $new' where the values of $old and $new can be specified by the
end user.  And then we keep old=good new=bad as the default.

And the best time to update the implementation to express its
operation in terms of 'find transition from $old to $new' is when
such a feature is introduced, in other words, inside this topic.

If you still are thinking in terms of 'find transition from $good to
$bad', then I can understand that you would disagree with the above,
but I think you are on the same page as Matthieu and me that we are
updating the system to use "'find transition from $old to $new' where
the values of $old and $new can be specified by the end user" as the
new paradigm.

And it is perfectly fine for the documentation to talk about the
feature using the default pair of words.

Hopefully this clarifies.
