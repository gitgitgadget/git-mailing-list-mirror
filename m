From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: use subshell instead of cd $new && .. && cd
 $old
Date: Tue, 31 Aug 2010 10:58:43 -0700
Message-ID: <7vaao2br58.fsf@alter.siamese.dyndns.org>
References: <1283169642-21917-1-git-send-email-avarab@gmail.com>
 <20100830155723.GC3292@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Carl Worth <cworth@cworth.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:59:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqV71-0000tm-M0
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab0HaR66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 13:58:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab0HaR65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 13:58:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C7DD2D6D;
	Tue, 31 Aug 2010 13:58:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FchhJbO709d3
	Nmeih61UXGLmin4=; b=JX6Wimwb9IpPeUBKrGuEdzJuwBebl0F+ilEACcXB2kmW
	grW8e+Ui/GqBs92UrMZjy/ag7OEYXmOxZoiTVZt+HBw24Ym2b9/uGA4RUjvLi5tO
	UFZ91B140otRkzMTKteya/hF7o4q6ENwYprpa8RWdMiY2jPmXCDi+ojJGPY3XWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TkUwl8
	tpyPTlDcLPnK4I16M15EM+UQBtmkiSccuoWu9wclnHGKOmOaOo+A3yaTfd7CwbCr
	36efOghQTIPTGEwl5lyehl9omIi0aAODlxJ7Cb5R4Vf4TaEPW+MwXCzzoqOFYrS6
	6U9IaUMd1qJbXOzTRV3Zpmi3hQr9xD2QNEMyY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8660AD2D6C;
	Tue, 31 Aug 2010 13:58:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71132D2D6A; Tue, 31 Aug
 2010 13:58:45 -0400 (EDT)
In-Reply-To: <20100830155723.GC3292@burratino> (Jonathan Nieder's message of
 "Mon\, 30 Aug 2010 10\:57\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69A6B3E0-B529-11DF-839B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154948>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> +++ b/t/test-lib.sh
>> @@ -687,14 +687,12 @@ test_when_finished () {
>>  test_create_repo () {
>>  	test "$#" =3D 1 ||
>>  	error "bug in the test script: not 1 parameter to test-create-repo=
"
>> -	owd=3D`pwd`
>>  	repo=3D"$1"
>>  	mkdir -p "$repo"
>> -	cd "$repo" || error "Cannot setup test environment"
>> +	(cd "$repo" || error "Cannot setup test environment"
>>  	"$GIT_EXEC_PATH/git-init" "--template=3D$GIT_BUILD_DIR/templates/b=
lt/" >&3 2>&4 ||
>>  	error "cannot run git init -- have you built things yet?"
>> -	mv .git/hooks .git/hooks-disabled
>> -	cd "$owd"
>> +	mv .git/hooks .git/hooks-disabled)
>
> Style: why not use
>
> 	(
> 		cd "$repo" ...
> 		... .git/hooks-disabled
> 	)

That is a sensible suggestion, but what does "error" do?

I think you would need || exit at the end, i.e.

	(
        	... || error "..."
	) || exit

or something.
