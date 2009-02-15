From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/8] config: Disallow multiple config file locations.
Date: Sun, 15 Feb 2009 14:44:29 +0200
Message-ID: <94a0d4530902150444t6e4dcd3btda79aaa0efebfe62@mail.gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902151324530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd25152559b7b0462f46efe
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 13:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYgNi-0003t7-VK
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 13:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbZBOMod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 07:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbZBOMoc
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:44:32 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:63588 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbZBOMob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 07:44:31 -0500
Received: by fxm13 with SMTP id 13so4876654fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 04:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=2rJrhNDNtquEIPhLjxyq+efWdzWFRj2J509aaR866vI=;
        b=m1201lUrfILbszEmAqceZlQPaub0yOPKsKYe9pypnp1DU8nTYRnCX+lGkL3RYPwF7U
         GTFNtk5mOeLFFlyrS323ks4PKlSxcnhKKV2InaxNNe6JnQZ2ZQbZV5NYDQxjlw4sg6X9
         SUBrBftt4KFOT8Abj5n4x7NdNhg8YQNUZ2Low=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kDec/XFWQKhOAH73SlnleifH+Vw6kHsd9GwZBDemn800r7+MeTGfMs8zTsyFK9yNRC
         S6W9Ly1pjDdZUnb5vegN+FaBsLL+6JmfBcXGMpNYWRCFMtIxR1buzJpyL2hXPTLkQ2L0
         CnOUfH1l857OwRuT5wMn3G2tPYIL1rYcZeUck=
Received: by 10.86.65.9 with SMTP id n9mr816780fga.61.1234701869488; Sun, 15 
	Feb 2009 04:44:29 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902151324530.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110004>

--000e0cd25152559b7b0462f46efe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Feb 15, 2009 at 2:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 15 Feb 2009, Felipe Contreras wrote:
>
>> Either --global, --system, or --file should be used, but not any
>> combination.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin-config.c |   10 ++++++++++
>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/builtin-config.c b/builtin-config.c
>> index 83f8b74..e744ad8 100644
>> --- a/builtin-config.c
>> +++ b/builtin-config.c
>> @@ -314,6 +314,16 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
>>
>>       argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
>>
>> +     {
>> +             int config_file_count = use_global_config + use_system_config;
>> +             if (given_config_file)
>> +                     config_file_count++;
>> +             if (config_file_count > 1) {
>> +                     error("only one config file at a time.");
>> +                     usage_with_options(builtin_config_usage, builtin_config_options);
>> +             }
>> +     }
>
> Hmm.  Is this a convoluted way to write
>
>        if (use_global_config + use_system_config + !!given_config_file > 1)
>
> or am I misunderstanding anything?

Ah, much better. (the !!foo trick is new to me)

-- 
Felipe Contreras

--000e0cd25152559b7b0462f46efe
Content-Type: application/octet-stream; 
	name="0005-config-Disallow-multiple-config-file-locations.patch"
Content-Disposition: attachment; 
	filename="0005-config-Disallow-multiple-config-file-locations.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr7plipj0

RnJvbSAxZWY3ZTI1MWEyYWIyNGYyMTNhZjMwMjJkZDBhOTg3ODVjODEyN2I3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KRGF0ZTogU3VuLCAxNSBGZWIgMjAwOSAxMDo0NjowMyArMDIwMApTdWJqZWN0OiBb
UEFUQ0ggNS84XSBjb25maWc6IERpc2FsbG93IG11bHRpcGxlIGNvbmZpZyBmaWxlIGxvY2F0aW9u
cy4KCkVpdGhlciAtLWdsb2JhbCwgLS1zeXN0ZW0sIG9yIC0tZmlsZSBzaG91bGQgYmUgdXNlZCwg
YnV0IG5vdCBhbnkKY29tYmluYXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgQ29udHJlcmFz
IDxmZWxpcGUuY29udHJlcmFzQGdtYWlsLmNvbT4KLS0tCiBidWlsdGluLWNvbmZpZy5jIHwgICAg
NSArKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1jb25maWcuYyBiL2J1aWx0aW4tY29uZmlnLmMKaW5kZXgg
MzBkZTkzZS4uY2RkOGExMiAxMDA2NDQKLS0tIGEvYnVpbHRpbi1jb25maWcuYworKysgYi9idWls
dGluLWNvbmZpZy5jCkBAIC0zMTMsNiArMzEzLDExIEBAIGludCBjbWRfY29uZmlnKGludCBhcmdj
LCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqdW51c2VkX3ByZWZpeCkKIAogCWFyZ2Mg
PSBwYXJzZV9vcHRpb25zKGFyZ2MsIGFyZ3YsIGJ1aWx0aW5fY29uZmlnX29wdGlvbnMsIGJ1aWx0
aW5fY29uZmlnX3VzYWdlLCAwKTsKIAorCWlmICh1c2VfZ2xvYmFsX2NvbmZpZyArIHVzZV9zeXN0
ZW1fY29uZmlnICsgISFnaXZlbl9jb25maWdfZmlsZSA+IDEpIHsKKwkJZXJyb3IoIm9ubHkgb25l
IGNvbmZpZyBmaWxlIGF0IGEgdGltZS4iKTsKKwkJdXNhZ2Vfd2l0aF9vcHRpb25zKGJ1aWx0aW5f
Y29uZmlnX3VzYWdlLCBidWlsdGluX2NvbmZpZ19vcHRpb25zKTsKKwl9CisKIAlpZiAodXNlX2ds
b2JhbF9jb25maWcpIHsKIAkJY2hhciAqaG9tZSA9IGdldGVudigiSE9NRSIpOwogCQlpZiAoaG9t
ZSkgewotLSAKMS42LjEuMwoK
--000e0cd25152559b7b0462f46efe--
