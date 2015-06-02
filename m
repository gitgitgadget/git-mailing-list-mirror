From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv3 2/2] git rebase -i: warn about removed commits
Date: Tue, 02 Jun 2015 11:22:19 -0700
Message-ID: <xmqqoaky2co4.fsf@gitster.dls.corp.google.com>
References: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433252180-25591-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<vpqzj4ignwe.fsf@anie.imag.fr>
	<133653833.39653.1433262736640.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:22:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzqpX-0007o0-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbbFBSWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:22:23 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36022 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbbFBSWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:22:22 -0400
Received: by ieclw1 with SMTP id lw1so44372515iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nCCQCjaKR48ZRYIlpRk2XOKh1/U0KIDNYiRzDFk6arY=;
        b=O5Evq4nA/O7ACh7yKQ/l632xjfdqbGsAlkoLKRMwDNwykXTs9ZMoI0c4LyU5m1HijN
         iFsj+YspuOQkyJ0vcippp9RqhCY3Yz9+c35I2qoIeje0XrTErkmLHevEnhrSDF9qcCN3
         qYOg8IeLnrZoFAEssOCFoazHO8Zm9IbWs1GitgDf9KJN6Gm9Kzv9PH9HlEhmWLuYWT8U
         xEm6os5nuurlh5x+Jk7bAWBx41L4BF6+L3vtuzjv4THzkiLUu7/DsDNSPpSQWvpngGcB
         lKzD6oooYtS5CFdwetIoVQ1Sk6Z4hDZB+Iu+r3qqauroW3QsezBwacTV1snTSsiWpU7a
         lXQw==
X-Received: by 10.107.47.4 with SMTP id j4mr35878709ioo.17.1433269341650;
        Tue, 02 Jun 2015 11:22:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id h33sm13009303iod.12.2015.06.02.11.22.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 11:22:20 -0700 (PDT)
In-Reply-To: <133653833.39653.1433262736640.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 2 Jun 2015 18:32:16 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270578>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> In this case it is not true, because of the infile and outfile being
> identical. However sort does have a -o (-output) that I missed that
> allows avoiding using echo or writing in another file; I'm correcting
> with this.

Even though it is in POSIX, some implementation may lack it, so our
code tend to avoid "sort -o".  "echo $(sort)" is also ugly and
inefficient.  The obvious and old-fashioned would be sufficient here:

	sort -u "$todo".oldsha1 >"$todo".oldsha1+ &&
        mv "$todo".oldsha1+ "$todo".oldsha1
