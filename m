From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: implement suggestions made by perlcritic
Date: Thu, 21 Mar 2013 22:21:38 +0530
Message-ID: <CALkWK0kkWAkiANL-vL-OthKSDkoU2b_Q68frkGc06QNG7RbSFQ@mail.gmail.com>
References: <1363869587-10462-1-git-send-email-artagnon@gmail.com> <7vd2usbwkn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 17:52:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIij6-0000Ob-M4
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 17:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923Ab3CUQwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 12:52:00 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:55487 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab3CUQv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 12:51:59 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so2706331iac.33
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kDlJZ9OxH37bu4mXH+AqYNwuC5t2qNm6TRJ57X0tb6c=;
        b=N53cw598NGBth0lnDuSpNor//ws6IzTeZ75GTBmJj4XtPD6vDpEX4Z2+sJDaIhVC/5
         /0FPGCZ5XXnqJEOEpcYkq05FJIQWCF/cjbFYVYELSpeRghObzFiC3KTWODPC6vB+2Eco
         NO9atobEz5r/8X7TfcI7Z+qg76h0lgCvUWgkUObzZXZC1Wa71guEX0CBujdO7fZIxsx/
         FN+ou6hNV0hyK8jhKd1jUM+r86EEt9cNUJ29DD/n57dhnAbav7VYdQ4bmXYuYrw3lYv8
         n4MiYzcYK8IRyjEhZnjwkbIayciHLvOSTItkE5Sd8lUh0qGq45LMY8YmsKn4zW7M/pg0
         Eq/w==
X-Received: by 10.50.50.71 with SMTP id a7mr2587536igo.14.1363884718737; Thu,
 21 Mar 2013 09:51:58 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 21 Mar 2013 09:51:38 -0700 (PDT)
In-Reply-To: <7vd2usbwkn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218743>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index be809e5..e974b11 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -513,7 +513,7 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
>>  ($sender) = expand_aliases($sender) if defined $sender;
>>
>>  # returns 1 if the conflict must be solved using it as a format-patch argument
>> -sub check_file_rev_conflict($) {
>> +sub check_file_rev_conflict {
>
> Have you verified that the callers of this sub are OK with this
> change?  It used to force scalar context on its arguments but now it
> does not.
>
> I am not saying I know the callers will get broken.  I am trying to
> make sure that this is *not* the result of blindly following
> perlcritic output without understanding the ramifications of the
> change.

No Junio, I haven't blindly followed the perlcritic output.  I've
considered the ramifications, audited the callers, and run the tests
to make sure that nothing breaks.

>> @@ -1438,7 +1438,7 @@ sub recipients_cmd {
>>
>>       my $sanitized_sender = sanitize_address($sender);
>>       my @addresses = ();
>> -     open my $fh, "$cmd \Q$file\E |"
>> +     open my $fh, q{-|}, "$cmd \Q$file\E"
>
> Strange quoting (why not just say "-|"?) aside

Intentional.  I thought it was a pretty way to differentiate between a
mode string (which can only be <, >, or -|) and a filename string.  If
you don't share my taste, feel free to use quotes instead.

> , if you are moving
> away from the two-param form of open(), it would be a sane thing to
> do to also stop concatenating the arguments to commands to avoid
> shell metacharacter gotcha.  It will make the resulting code much
> safer.

Yes, the file can be improved in many ways, but that is not the topic
of this series.  This series just makes the changes suggested by
perlcritic gentle.
