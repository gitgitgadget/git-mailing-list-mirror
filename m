From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/3] git-p4: add failing test for P4EDITOR handling
Date: Wed, 20 May 2015 12:54:31 -0700
Message-ID: <xmqq617nnhxk.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
	<1432074198-13806-1-git-send-email-luke@diamand.org>
	<1432074198-13806-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed May 20 21:54:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvA4e-00037x-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbbETTyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 15:54:36 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35911 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbbETTye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:54:34 -0400
Received: by iepj10 with SMTP id j10so47656985iep.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Bubqc83eQntlOd09gBtUyzZ9XHjpeArpSTYeqpke5YI=;
        b=W8ntGFKohDC3VASkzl1wHlV5rIcL0jH85h/+dbKG9dKV0lgn07zOXCjkHeJ6LNhPMB
         /Tybvj+j7/M/by2slynj5HVo4aCRlPcLTf5WojfcCTiiO/Fz5svZuGzC4cBL7yhVFGDO
         6EkiCRxMxBpanwNJw2Oz//xm27Yp9klWoqn4NASNGK0aFhFFR4Qw4jQxknQi5pldKVCJ
         mPNM11eZPL250NwisD/c131usrdxmaf0ruZkSqVhGik/SHWe5fyIbveZakfuR1IyI+Yu
         dA0M4g8PtI5klDGtb+GuN9TjOexZw7U13ijClkZMJZj2jUup9F7pCHvSB10MrAVDmOZA
         CEiA==
X-Received: by 10.107.13.11 with SMTP id 11mr46077217ion.70.1432151673416;
        Wed, 20 May 2015 12:54:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id p74sm13083337ioe.27.2015.05.20.12.54.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 12:54:32 -0700 (PDT)
In-Reply-To: <1432074198-13806-2-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Tue, 19 May 2015 23:23:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269512>

Luke Diamand <luke@diamand.org> writes:

> +
> +test_expect_failure 'EDITOR has options' '
> +# Check that the P4EDITOR argument can be given command-line
> +# options, which git-p4 will then pass through to the shell.
> +test_expect_success 'EDITOR has options' '
> +	git p4 clone --dest="$git" //depot &&

Oops?  I assume that the one before the comment should go and this
one is

	test_expect_failure 'Editor with an option' '

or something.

> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		echo change >file1 &&
> +		git commit -m "change" file1 &&
> +		P4EDITOR=": >\"$git/touched\" && test-chmtime +5" git p4 submit &&
> +		test_path_is_file "$git/touched"
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
